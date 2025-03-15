-- Her har vi antatt at flyselskap skal være mer selv om de ikke har noen registrete flytyper (Grunnen til at vi bruker LEFT JOIN og ikke INNER JOIN)
-- Vi har også antatt at vi har bruke order by for å gruppere 


SELECT 
    f.navn AS flyselskap, 
--Denne linjen skal sørge for at hvis flyselskapet ikke har noen flytyper så skal dette vises som "Ingen registrert flytype" og ikke  NULL
    IFNULL(ft.flytypeNavn, 'Ingen registrert flytype') AS flytype, 
    COUNT(fly.regnr) AS antall_fly
FROM Flyselskap f
LEFT JOIN Fly fly 
    ON f.flyselskapID = fly.tilhorerSelskapID
LEFT JOIN Flytype ft 
    ON fly.erType = ft.flytypeNavn
GROUP BY 
    f.navn, 
    ft.flytypeNavn
ORDER BY 
    f.navn ASC, 
    antall_fly DESC;
