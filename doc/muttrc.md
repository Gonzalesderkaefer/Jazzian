# How to setup mutt (or neomutt) for basic email stuff

## muttrc example

```
# For incoming mail
set spoolfile = "imaps://imap.serveraddress.me:portnumber"
set imap_user = "ur@email.me"

# For outgoing mail
set smtp_url = "smtp://ur@email.me@smtp.serveraddress.me:portnumber"
# sometimes sending does not work try omtitng the portnumber

# Configure Inbox
set folder = $spoolfile

# Sent mail
set record = "+Sent"

# Delete mail
set trash = "+Trash"

# Drafts 
set postponed = "+Drafts"

mailboxes $postponed $record $trash
```


## Setting password

create a file `$HOME/.mutt/password` with following content:
```
set imap_pass = "uremail password"
set smtp_pass = "uremail password"
```
create a gpg key with `gpg --full-gen-key` and remember the email.
Then encrypt the the password file `gpg -r <the email you entered> -e $HOME/.mutt/password`.
There will be a new file called `password.gpg`.
Overwrite the unencrypted file with zeroes `shred $HOME/.mutt/password` 
Then remove it with `rm $HOME/.mutt/password`.

In you muttrc file add the following line:
```
source 'gpg -d $HOME/.mutt/password |'
```

