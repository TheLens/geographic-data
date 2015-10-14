## Louisiana and New Orleans geographic data

A collection of cleaned geographic data for New Orleans and Louisiana, along with a fully scripted data-cleaning process using command line tools.

__Table of contents__

* [What's included](#whats-included)
* [Data release schedule](#data-release-schedule)
* [Known problems](#known-problems)
* [Future releases](#future-releases)
* [Contributing to this project](#contributing-to-this-project)
* [Setup for development](#setup-for-development)
* [Contact](#contact)
* [License](#license)

## What's included

All files that are ready for use are stored in the `exports` directory. Each geography includes a full-sized version with all original metadata, as well as a simplified version (using the suffix `-simplified`) with less accurate boundaries that is smaller in size than the original and only includes the relevant metadata. The simplified versions are more suitable for web applications because of their smaller file sizes.

All files are available in the ESRI Shapefile (.shp), GeoJSON (.json) and TopoJSON (.json) file formats.

Click the links below to see previews of each geography.

|               |Geography                                                                                                                                           |Shapefile|GeoJSON |TopoJSON|
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|--------:|-------:|-------:|
|__New Orleans__|[City limits](exports/topojson/parishes/new-orleans.json)                                                                                           | 43   kB | 72   kB| 21   kB|
|               |[City limits (simplified)](exports/topojson/parishes/new-orleans-simplified.json)                                                                   |  5   kB |  9   kB|  3   kB|
|               |[City limits, without Lake Pontchartrain](exports/topojson/parishes/new-orleans-no-lake.json)                                                       |116   kB |195   kB| 49   kB|
|               |[City limits, without Lake Pontchartrain (simplified)](exports/topojson/parishes/new-orleans-no-lake-simplified.json)                               | 10   kB | 17   kB|  6   kB|
|               |[City limits, without Lake Pontchartrain and Mississippi River](exports/topojson/parishes/new-orleans-no-lake-no-river.json)                        |131   kB |219   kB| 55   kB|
|               |[City limits, without Lake Pontchartrain and Mississippi River (simplified)](exports/topojson/parishes/new-orleans-no-lake-no-river-simplified.json)| 11   kB | 18   kB|  6   kB|
|               |[Neighborhoods](exports/topojson/neighborhoods/new-orleans.json)                                                                                    |239   kB |658   kB| 95   kB|
|               |[Neighborhoods (simplified)](exports/topojson/neighborhoods/new-orleans-simplified.json)                                                            | 45   kB |121   kB| 30   kB|
|               |[Voting precincts](exports/topojson/precincts/new-orleans.json)                                                                                     |545   kB |  1.6 MB|265   kB|
|               |[Voting precincts (simplified)](exports/topojson/precincts/new-orleans-simplified.json)                                                             | 70   kB |192   kB| 78   kB|
|__Louisiana__  |[Parishes](exports/topojson/parishes/louisiana.json)                                                                                                |  7.5 MB | 12.5 MB|  1.3 MB|
|               |[Parishes (simplified)](exports/topojson/parishes/louisiana-simplified.json)                                                                        |626   kB |  1.1 MB|308   kB|
|               |[Voting precincts*](exports/topojson/precincts/louisiana.json)                                                                                      | 31.4 MB | 89.6 MB|  5.9 MB|
|               |[Voting precincts (simplified)](exports/topojson/precincts/louisiana-simplified.json)                                                               |  3.6 MB | 10.1 MB|  2.2 MB|
|               |[BESE districts](exports/topojson/bese/bese.json)                                                                                                   |  2.3 MB |  6.3 MB|446   kB|
|               |[BESE districts (simplified)](exports/topojson/bese/bese-simplified.json)                                                                           |260   kB |728   kB| 91   kB|
|__Water__      |[Mississippi River](exports/topojson/water/mississippi-river.json)                                                                                  |968   kB |  1.5 MB|242   kB|
|               |[Mississippi River (simplified)](exports/topojson/water/mississippi-river-simplified.json)                                                          | 73   kB |123   kB| 36   kB|
|               |[Lake Pontchartrain](exports/topojson/water/lake-pontchartrain.json)                                                                                |203   kB |340   kB| 78   kB|
|               |[Lake Pontchartrain (simplified)](exports/topojson/water/lake-pontchartrain-simplified.json)                                                        | 13   kB | 22   kB|  7   kB|
|               |[Gulf of Mexico](exports/topojson/water/gulf-of-mexico-simplified.json)                                                                             |  4.4 MB |  7.4 MB|  1.1 MB|
|               |[Gulf of Mexico (simplified)](exports/topojson/water/gulf-of-mexico-simplified.json)                                                                |667   kB |  1.1 MB|326   kB|

*__Note:__ The Louisiana precincts file from the House of Representatives is almost always out of date, so only use this file for historical data. This would not be suitable for an election night live data feed because the parcel shapes won't match.

## Data release schedule

|               |Data                    |Last release|Next expected release|
|---------------|------------------------|-----------:|--------------------:|
|__New Orleans__|Neighborhoods           |8/25/2015   |Uncertain            |
|               |Precincts               |10/2/2015   |Uncertain            |
|__Louisiana__  |Parishes                |11/10/2010  |11/10/2020           |
|               |Precincts (statewide)   |Uncertain   |Uncertain            |
|__Water__      |Mississippi River       |8/12/2015   |8/12/2016            |
|               |Lake Pontchartrain      |8/12/2015   |8/12/2016            |
|               |Gulf of Mexico          |8/12/2015   |8/12/2016            |

## Known problems

Statewide precincts file is often out of date for at least some parishes. Some parishes update their precincts faster than the state can release new precinct files. The state does not release a given elections' precincts shapefile until after the election. This file is mostly created for historical data analysis, and should not be assumed to be presently accurate. Don't use this file for live election night coverage!

## Future releases

See the Issues tagged "data-suggestion" for plans for the future. Comment on those issues if you'd rather see some sooner than others.

## Contributing to this project

See [`CONTRIBUTING`](CONTRIBUTING) for the full details about how you can contribute to this project. Here are the basics:

Report bugs, ask questions and suggest features on the [Issues](https://github.com/TheLens/geographic-data/issues) page. If you aren't sure whether you should submit a pull request or not, just do it. I'm not picky and would much rather receive some sort of help and have to make adjustments than receive no help at all.

## Setup for development

All cleaning is done using the command-line tools `ogr2ogr` and `topojson`. A single Makefile scripts each step, which makes use of other Unix utilities.

#### Installation

If possible, use a package manager such as [Homebrew](http://brew.sh/) for Mac or [apt-get](http://manpages.ubuntu.com/manpages/raring/man8/apt-get.8.html) for Linux to make your life easier.

__ogr2ogr__

Linux:

```bash
apt-get install gdal-bin

# May need to run as super user.
# If you get a permissions error, try running the following:
# sudo apt-get install gdal-bin
```

Mac: `brew install gdal`

__topojson__

Relies on node.js. See below for how to install node.js.

Linux: `npm install -g topojson`

Mac: `npm install -g topojson`

__node.js__

Linux: `apt-get install nodejs`

Mac: `brew install node`

## Contact

This repo is maintained by [Thomas Thoren](https://github.com/ThomasThoren). Please contact tthoren@thelensnola.org with any questions.

###License

MIT. See [`LICENSE`](LICENSE) for full information.
