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

If you're on a mac, most of this stuff can be `brew install`ed.
```sh
brew install bash lastpass-cli jq mutt urlview
```

If you're on linux you'll find similar stuff in your favourite package manager.
I find that `mutt` works best for me on the mac, and `neomutt` works best for me
on ubuntu. YMMV.

## Getting Going

Get these scripts, setup your creds, then run imutt:

### Get scripts

Clone this repo somewhere, and add that somewhere to your path. For example:

```bash
git clone https://github.com/totherme/imutt.git ~/bin/imutt
cd ~/bin/imutt
git submodule update --init
echo 'export PATH="$HOME/bin/imutt:$PATH' >> ~/.profile
```

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

The `imutt-edit-creds` script can help with this.

If you're using gmail, you'll have to [enable 2 factor
auth](https://support.google.com/accounts/answer/185839?hl=en), and [create an
app specific
password](https://support.google.com/accounts/answer/185833?hl=en). This is the
password that you'll need to put in your creds -- *not* your regular google
password.

### Run

```bash
imutt
```

## How to use

If you're not familiar with mutt, check out [the
manual](http://www.mutt.org/doc/manual/). Note that any [email
aliases](http://www.mutt.org/doc/manual/#intro-alias) you create will be stored
in lastpass at the path `Personal/email-aliases`. You can hand-edit this file
with `imutt-edit-aliases`.

This config adds only a couple of non-standard bindings. My philosophy is an
inbox-zero-like one. Here's my email workflow:

- Open one of my inboxes, and read the mail in it.
  + There may be messages I don't need to read -- I can tell just from looking at
    the sender and subject that they can be ignored. For these emails, instead of
    hitting `enter` to read them, I hit `d` for `done`. This marks the messages as
    read. It does not delete them.
  + If there are messages I need to deal with later, I can hit `F` to **f**lag them as
    important (like "starring" them in gmail), and add whatever note I need to add
    in an external todo list.
  + If there are messages which aren't filed correctly, I hit `B` to open that
    email in my web browser in gmail. Here I can create a new filter so that the
    next time an email like this arrives, it will be filed correctly.
  + Of course I can reply with `r`, group reply with `g` and so on.
- Open another inbox, or quit mutt. Either way, **all read emails will be moved
  into an archive folder**. If I was just reading the folder `${MBOX}`, then the
  read emails will be moved to `${MBOX}-archive`.

## Philosophy and limitations

This config is intended to be fairly safe to use on [pairing
workstations](http://engineering.pivotal.io/categories/pair-programming/). In
that environment, we don't want to leave emails or creds on the local disk. With
no local copies, every time we open a mailbox we're reading data over the
network, and hence loading large inboxes can be annoyingly slow. It therefore
makes sense to develop a habit of keeping "read mail" in archives where I rarely
look, and "new or unactioned email" in small inboxes that load fast when I need
them.

If you want a mutt config for a machine that only you ever use, this may not be
for you. You might find you'd prefer to keep copies of your email locally,
perhaps synced in the background with a tool like
[offlineimap](http://www.offlineimap.org/).
