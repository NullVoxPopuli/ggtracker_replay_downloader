# ggtracker_replay_downloader
A script to download StarCraft 2 replays from ggtracker.

## Setup instructions
  - [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
  - Have bundler installed (usually `gem install bundler`)
  - `gem install curb`

## Running the script

Download the zip for this repository, or clone it.
Then, in the terminal `cd ggtracker_replay_downloader`

modify the script in two places to meet your needs:
on the line that starts:
```ruby
def get_all_replay_ids_for_identity
```
Change the `identity` to your ggtracker identity for your account.  
For example, for your profile URL:  
`ggtracker.com/players/4914/LindyHop`  
4914 is the identity

then, in the terminal:
```
ruby download.rb
```

The files will be downloaded to a folder called "ggtracker-replays"
