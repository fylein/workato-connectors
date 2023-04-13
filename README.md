# workato-connectors
Open sourced Workato connector SDKs currently used to build integrations at Fyle

## Installing Ruby on Mac

MacOS already comes with a ruby version `2.6.0` but that version will not work with workato cli
you need to download version 2.7.0 or greater

## installing rvm

run the following commands
1. `\curl -sSL https://get.rvm.io | bash`
2.  rvm install 3.1.2
3.  rvm use 3.1.2

don't forget to quit and reopen the terminal

## installing workato sdk

`gem install workato-connector-sdk`

type `workato` in the terminal to verify the install


## running workato based connectors locally

### running actions

`workato exec actions.new_record.execute`

