This project is just a simple API to provide the nearest public transport stations in the Paris area.


## Data sources
---

The data provided by this API use the official data provided by RATP on their [Open Data website](http://data.ratp.fr/).

The original data file is a simple [CSV files](http://data.ratp.fr/fr/les-donnees/fiche-de-jeu-de-donnees/dataset/positions-geographiques-des-stations-du-reseau-ratp.html?tx_icsoddatastore_pi1%5Bpage%5D=2&tx_icsoddatastore_pi1%5BreturnID%5D=38).

This API add the ability to sort the stations by proximity, filtered by transport type and get the distance from the location in parameters.


## Technical stack
---

This API is a simple Sintatra app with a MongoDB database, using MongoID to provide most of the nearby/distance features.

Feel free to for this project if anything come to your mind!


## Demo Webapp
---

A demo very basic webapp made with JQuery and Ratchet is available on [http://paris-stations.herokuapp.com/](http://paris-stations.herokuapp.com/)


## API Documentation
---

API Base URL: `http://paris-stations.herokuapp.com/`

### GET Stations

* `GET /stations` return an array of Stations sorted relatively to the location set in parameters

** Arguments **

- ll -> Latitude and Longitude separated by a comma (**REQUIRED**)
-  n -> Number of results (default 10)
-  types -> types of transportation way, see the /transport_types endpoint for available values (default all)

** Response **

```
[
	{
		"city": "SAINT-OUEN",
		"geo_near_distance": 0.002472258879984481,
		"name": "Mairie de Saint-Ouen",
		"ratp_id": 1818,
		"type": "metro",
		"latitude": 48.9120620157054,
		"longitude": 2.334163015407
	},
	{
		"city": "SAINT-OUEN",
		"geo_near_distance": 0.008066203180195424,
		"name": "Garibaldi",
		"ratp_id": 1844,
		"type": "metro",
		"latitude": 48.9060316197727,
		"longitude": 2.33173327604333
	},
	{
		"city": "SAINT-DENIS",
		"geo_near_distance": 0.011829296827288251,
		"name": "Carrefour-Pleyel",
		"ratp_id": 228266,
		"type": "metro",
		"latitude": 48.9194552102366,
		"longitude": 2.34320024908898
	}
]
```

(original call : http://paris-stations.herokuapp.com/stations?ll=48.9140418,2.3326823&n=3&types=metro)

### GET Transport Types

* `GET /transport_types` return the array of transport types availables

** Response **

```
["metro","rer","bus","tram"]
```
(original call http://paris-stations.herokuapp.com/transport_types)


### Licence

The datas used in this project are available according to the [Etalab licence](http://wiki.data.gouv.fr/wiki/Licence_Ouverte_/_Open_Licence).

The source code is available on the MIT licence philosophie.