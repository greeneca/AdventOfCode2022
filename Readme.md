# Advent of Code 2022

## Setup

 The following command creates the two .rb files and downloads the input file.

 * Ensure that YEAR is set in setup script
 * Create `.session_token` file with a session token

  $ ./setup \<day\>

Example:

  $ ./setup 1

## Running

  The following command runs the approiate problem code with the given input,
  times the execution, and saves all stdout to a log file in the logs dir.

  $ ./advent \<problem\> \<input path\>

Example:

  $ ./advent 1-1 inputs/day1.txt
