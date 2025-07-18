SELECT
    alias,
    document_id,
    reference_time,
    subject,
    issuer
FROM
    cartorio.signature
WHERE
        alias = '97797111472'
    AND subject IS NOT NULL
ORDER BY
    reference_time DESC;

SELECT
    *
FROM
    cartorio.document
WHERE
    document_id IN ( '2054909', '2051439', '2041867', '2040807', '1401105',
                     '1391329' )
ORDER BY
    reference_time DESC;
