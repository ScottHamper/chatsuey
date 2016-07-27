ChatSuey - Retail
=================
A port of ChatSuey for the current retail version of WoW (7.0).
Learn about the vanilla version at the [project website](http://www.scotthamper.com/chatsuey/).

Installation
------------
1. Copy all the ChatSuey folders into your WoW `Interface\AddOns` directory.
2. If WoW is currently running, exit completely out and restart it.
3. Enable/disable desired addons at the character select screen ("RemoveButtons" is disabled by default).

NOTE: If you're upgrading from an earlier version, delete all the ChatSuey folders from your `Interface\AddOns` directory before copying the new ones over.

Differences From Vanilla
------------------------
- `ChannelLinks` became obsolete.
- `StickyChat` became obsolete.
- `Timestamps` became obsolete.
- `MarkdownLinks` became unusable - it's now impossible to send custom hyperlinks in chat.
- `ItemLinkHover` was renamed to `LinkHover` and expanded to include new types of hyperlinks (e.g., talents).
- `PlayerLinks` has reduced functionality - it's now impossible to link players in chat, and addons can no longer target units.
- `EditOnTop` is not ported yet.

TODO
----
- Add support for battle pet links to `LinkHover` addon. May be missing support for other "new" link types as well.
- Possibly add support for NPC say/yell/whisper to `MiniChannels` addon.
