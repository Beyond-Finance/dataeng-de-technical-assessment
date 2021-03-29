--1. How many different customers are there?
SELECT COUNT(*)
FROM customers;

--2. How long is the longest track in minutes?
SELECT MAX(milliseconds)/(60*1000) AS minutes
FROM tracks;

--3. Which genre has the shortest average track length?
SELECT name
FROM genres
WHERE genreid = ( SELECT genreId
                  FROM tracks
                  LEFT JOIN genres ON tracks.genreId = genres.genreId
                  GROUP BY tracks.genreId
                  ORDER BY AVG(tracks.milliseconds)
                  LIMIT 1);

--4. Which artist shows up in the most playlists?
SELECT artists.artistId
FROM playlist_track
LEFT JOIN tracks ON playlist_track.trackId = tracks.trackId
LEFT JOIN albums ON tracks.albumId = albums..albumId
LEFT JOIN artists ON albums.artistId = artists.artistId
GROUP BY artists.artistId
ORDER BY COUNT(playlist_track.playlistId) DESC
LIMIT 1;

--5. What album had the most purchases?
SELECT albums.albumId, albums.Title
FROM albums
LEFT JOIN tracks ON albums.albumId = tracks.albumId
LEFT JOIN invoice_items ON tracks.trackId = invoice_items.trackId
LEFT JOIN invoices ON invoice_items.invoiceId = invoices.invoiceId
GROUP BY albums.albumId, albums.Title
ORDER BY COUNT(invoice_items.invoiceId) DESC
LIMIT 1;