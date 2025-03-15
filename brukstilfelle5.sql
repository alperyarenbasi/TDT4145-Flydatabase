SELECT 
    f.navn AS flyselskap, 
    ft.flytypeNavn AS flytype, 
    COUNT(fly.regnr) AS antall_fly
FROM Flyselskap f
JOIN Fly fly ON f.flyselskapID = fly.tilhorerSelskapID
JOIN Flytype ft ON fly.erType = ft.flytypeNavn
GROUP BY f.navn, ft.flytypeNavn
ORDER BY f.navn, antall_fly DESC;