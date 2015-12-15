# Retsly

R bindings to get data from the Retsly API.  More information about the Retsly API here: https://rets.ly/docs/platform.html

## Retsly API
You must sign up for an account with Retsly at https://rets.ly .  After you sign up you must request access to different MLS datasets and the public datasets.

## Installation
Install with `devtools`.  If you don't have devtools, install it using `install.packages("devtools")`.  After you have devtools installed you can install the Retsly package using: `devtools::install_github("ALShum/Retsly")`.

## Basic functionality

#### Security Token:
Before you can use the Retsly API make sure you have your access token.  You should be able to get an access token after registering a Retsly account.  The easiest way to use the Retsly R API is to set your access token as an environment variable.

To create/modify an .Renviron file see here for instructions: http://astrostatistics.psu.edu/su07/R/html/base/html/Startup.html

Once you find your .Renviron file add the following line:
```
retsly_api_token = "INSERT YOUR ACCESS TOKEN HERE"
```

If you absolutely can't be bothered to find your .Renviron file you can set your environment variables every time you restart R:

```
Sys.setenv(retsly_api_token = "INSERT YOUR TOKEN HERE")
```

Alternatively you can just include your access token in all your function calls:

```
opts = retsly_query(access_token = "INSERT YOUR TOKEN HERE")
```

The above will create an options list and you will need to include this in all of your function calls.  For example, to make a grab parcels data with the above manually specified access token:

```
parcels(opts = opts)
```

If you go this route, you will need to include your access token as part of the options list for every API function call.

#### Available Datasets:

```
list_datasets()
```

The above will list all of the datasets available through Retsly -- this is not necessarily the same set of datasets you will have access to.  You must request access to the different datasets (besides the datasets listed as 'test').

#### MLS and Public
Datasets can be roughly split into 2 categories: MLS data and Public listings data.  Public listings data includes information on parcels, assessments and transactions -- these functions should request data from the `pub` dataset.  The MLS functions can pull data from different MLS providers -- these functions should request data from one of the available MLS datasets.

#### Parcels
To get public parcel data:

```
parcels()
```


#### Assessments
To get public assessment data:

```
assessments()
```

#### Transactions
To get public transactions data:

```
transactions()
```


#### Listings
To pull listings data from the `test_sf` dataset:

```
listings(dataset = "test_sf")
```

To pull a specific listing by a listing id from the `test_sf` dataset:

```
listings(dataset = "test_sf", list_id = "PUT LISTING ID HERE")
```

To pull the real estate office or agent associated with a specific listing id from the `test_sf` dataset:

```
listings_agent(dataset = "test_sf", list_id = "PUT LISTING ID HERE")
listings_office(dataset = "test_sf", list_id = "PUT LISTING ID HERE")
```

#### Agents
To pull data about real estate agents from the `test` dataset:

```
agents(dataset = "test")
```

To pull data about a specific real estate agent or to find all the listings associated with a specific agent from the `test` dataset:

```
agents(data = "test", agent_id = "PUT AGENT ID HERE")
agents_listings(data = "test", agent_id = "PUT AGENT ID HERE")
```

#### Offices
To pull data about real estate offices from the `test_sd` dataset:

```
offices(dataset = "test_sd")
```

To pull data about a specific real estate office, agents or listings from a specific office from the `test_sd` dataset:

```
offices(dataset = "test_sd", office_id = "PUT OFFICE ID HERE")
offices_agents(dataset = "test_sd", office_id = "PUT OFFICE ID HERE")
offices_listings(dataset = "test_sd", office_id = "PUT OFFICE ID HERE")
```

#### Media


#### Vendors
To get a list of approved vendors (MLS vendors and other datasets which you have access to):

```
vendors_aproved()
```

## Advanced functionality
By default, when you make a request to the Retsly API it will return the first 100 rows of the dataset.  To grab additional data you can also specify the ordering, number of rows returned and many other parameters.

#### Query parameters
Query parameters can be set using `retsly_query`.  The following query parameters can be specified:

* offset: 
* limit: 
* sortBy: 
* order: 
* near: 
* radius: 

#### Custom queries