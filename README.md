# IMAP Mutt Configs

I want to keep all my email on my email server, and all my creds in lastpass. And still use mutt.

This config pulls my IMAP password from lastpass _just_ long enough to pass through a named-pipe to mutt.

## Prereqs

- [Mutt](http://www.mutt.org/) or [Neomutt](https://neomutt.org/)
- A [lastpass](https://www.lastpass.com/) account
- The [lpass CLI](https://github.com/lastpass/lastpass-cli)
- [jq](https://stedolan.github.io/jq/)
- A terminal with a recent version of bash, mkfifo, mktemp, etc
  + If you're using a mac, you'll have to `brew install bash` to get a bash
    newer than version 3.

## Usage

Setup your creds, get these scripts, then run them:

### Setup creds
First, create a lastpass note at path `Personal/email-creds`, with contents like the following:

```json
{
  "user-email-address": "me@where.ever.i.live",
  "user-full-name": "My Name",
  "imap-address": "imap.gmail.com or similar",
  "smtp-address": "smtp.gmail.com or similar",
  "smtp-port": "587 or similar",
  "username": "my-username",
  "password": "my-password",
  "mailboxes": "\"+my-first-inbox\" \"+my-second-inbox\" \"etc\""
}
```

If you only have one inbox, and it's called `INBOX`, then set the `mailboxes`
line to `""`. I like to have different inboxes for each of my mailing lists.

If you're using gmail, you'll have to [enable 2 factor
auth](https://support.google.com/accounts/answer/185839?hl=en), and [create an
app specific
password](https://support.google.com/accounts/answer/185833?hl=en). This is the
password that you'll need to put in your creds -- *not* your regular google
password.

### Get scripts

Clone this repo somewhere, and add that somewhere to your path. For example:

```bash
git clone https://github.com/totherme/imutt.git ~/bin/imutt
cd ~/bin/imutt
git submodule update --init
echo 'export PATH="$HOME/bin/imutt:$PATH' >> ~/.profile
```

### Run

```bash
imutt
```

## One last thing

If you happen to be using gmail to host your email, you might sometimes want to
open a given email in the gmail web UI. You can do that with `B`.
