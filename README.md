# Prerequisites
The Setup section expects following to be installed:
- Github
- Ruby [2.6.6](https://github.com/lbmeira/outdoorsy/blob/main/.ruby-version#L1)
- Rails [6.0.5](https://github.com/lbmeira/outdoorsy/blob/main/Gemfile#L7)


# Setup
1. Check out the repository
```
https://github.com/lbmeira/outdoorsy.git
```
2. Run database migrations
```
rake db:migrate
```
3. Confirm that the migrations ran successfully 
```
rake db:migrate:status
```

# Usage
**Running testing suite:**
```
rails t
```

**Importing customer data:**
```
# Imports customer data separated by commas
rake import_customer_data['test/fixtures/files/commas.txt','\,']
```

```
# Imports customer data separated by pipes
rake import_customer_data['test/fixtures/files/pipes.txt','|']
```
The `import_customer_data` rake task will create **new** `Person` and `Vehicle` DB records

**Exporting customer data:**
* Customer data includes: First name, Last name, Email, Vehicle type, Vehicle name, and Vehicle length
```
# Exports customer data sorted by vehicle type
rake export_customer_data['vehicle_type']
```

```
# Exports customer data sorted by full name
rake export_customer_data['full_name']
```
The `export_customer_data` rake task will export the customer data to a comma separated file with a named based on the time of the export run (`"customer_data_export_#{Time.now.strftime("%Y%m%d%k%M%S")}.csv"`)

# Assumptions
* We want the data in a persistent storage
* Expect customer data input to be valid
* Expect file format to be a comma/pipe separated .txt
* We are asumming a person (customer) can have multiple vehicles

# Future enhancements
* Improve test coverage and add corner cases
* Add more logging
* Performance testing
* Add data validation and error handling
* Linting

# Additional questions
* Who are the stakeholders (customer)? What do they care about?
* How does Outdoor.sy expect to use this tool?
* How many users do we expect to use this tool at the same time?
* How big are the customer files?
* (Security) Are there any special considerations around the data that is captured today or that might be captured in the future (PII)?

# Problem statement
We’d like you to code a small tool for a fictional company called Outdoor.sy that takes some of their customer lists and returns the data in different sorted orders.
We expect a very rudimentary app and you can choose which technologies to use. You can build this in a back-end language (we do love Ruby) and call it from the command line, or you can build it all in javascript and load the lists in memory and display them on a web page, or you can build a small full-stack app that has both, etc. We recommend you pick technologies that you're comfortable with so you can focus on demonstrating what you know. We expect folks to build something in one or two short sittings and don’t want to take up a substantial amount of your time.
You should be able to run this app on your computer and post the work to github or email us the code. Please include a readme so we know how to run it. You can have the app afterwards - the code is yours, so feel free to use it as part of your portfolio, etc.

Input data:
Each file has a list of data with the following fields: First name, Last name, Email, Vehicle type, Vehicle name, and Vehicle length. The data will be separated by a pipe or a comma and the data fields themselves don’t contain those separators.

Here’s what we want the tool to do:
1. Add data from an upload file (ie: an argument in command line or file input)
2. Display the information Outdoor.sy wants to see about their customers: Full name, Email, Vehicle type, Vehicle name, Vehicle length
3. Sort the data by Vehicle type or by Full name

You can decide how to present the data based on the tech stack that you choose, but get as far as you can with those features and if you think of other enhancements you’d like to do along the way - that’s great, too! This is meant to allow you to demonstrate strengths that you’d like to highlight. Please keep code structure, naming, and testability in mind - we’re more interested in code patterns and code design than any specific features. And if you have any questions, please feel free to email anytime - that is part of the process in the real world!

