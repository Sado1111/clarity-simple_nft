;; simple-nft.clar
;; A basic NFT implementation in Clarity 2.0

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-token-exists (err u102))
(define-constant err-token-not-found (err u103))
(define-constant err-invalid-token-uri (err u104))  ;; New error for invalid token URI

;; Data Variables
(define-non-fungible-token simple-nft uint)
(define-data-var last-token-id uint u0)
(define-map token-uri uint (string-ascii 256))

;; Private Functions
(define-private (is-token-owner (token-id uint) (sender principal))
    (is-eq sender (unwrap! (nft-get-owner? simple-nft token-id) false)))

;; Validate Token URI
(define-private (is-valid-token-uri (uri (string-ascii 256)))
    (let ((uri-length (len uri)))  ;; Get the length of the string
        (and (>= uri-length u1)      ;; Check if not empty
             (<= uri-length u256)))) ;; Check length

;; Public Functions
(define-public (mint (token-uri-data (string-ascii 256)))
    (let ((token-id (+ (var-get last-token-id) u1)))
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (asserts! (is-valid-token-uri token-uri-data) err-invalid-token-uri)  ;; Validate URI
        (try! (nft-mint? simple-nft token-id tx-sender))
        (map-set token-uri token-id token-uri-data)
        (var-set last-token-id token-id)
        (ok token-id)))

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
    (begin
        ;; Ensure that the recipient is a valid principal
        (asserts! (is-eq recipient tx-sender) err-not-token-owner)
        
        ;; Get the actual owner of the token
        (let ((actual-sender (unwrap! (nft-get-owner? simple-nft token-id) err-not-token-owner)))
            ;; Check if the actual sender is the one trying to transfer
            (asserts! (is-eq actual-sender sender) err-not-token-owner)

            ;; Proceed with the transfer
            (try! (nft-transfer? simple-nft token-id sender recipient))
            (ok true))))

;; Read-Only Functions
(define-read-only (get-token-uri (token-id uint))
    (ok (map-get? token-uri token-id)))

(define-read-only (get-owner (token-id uint))
    (ok (nft-get-owner? simple-nft token-id)))

(define-read-only (get-last-token-id)
    (ok (var-get last-token-id)))
