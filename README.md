# Hearizons

It's for the Hearizons server. The function of Hearizons is basically split between two phases:
1. A submissions phase where people send links/names to their song they're submitting
2. The submitted songs are then assigned randomly to different people and everyone gives their review about it.

For the user it would look like this:
- They have a channel that they may send submissions in when the submissions phase is ongoing. The bot would then register that assignment and delete the message. The user is then locked out of sending further messages for that cycle. If they wish to change their submission, they can press a reaction to remove their submission and they would be able to send a message again. The channel is closed whenever submissions are not open.
- The bot then randomly distributes the songs to each participant and gives a role to each participant. When the participant gives their review in the #review channel (on Hearizons it's #official-comments") they lose the role and are unable to send a message.
- If someone hasn't reviewed their assigned song they would be locked out from further submissions until they review the song.

For us (the admins) the following would be nice:
- Be able to extend a phase's duration
- Browse current submissions
- Re-randomize the assignments
- Remove a participant's submission

Also if possible it would be nice to be able to run 2 cycles at the same time but that's not mandatory (e.g normal cycle (with songs) coexisting with special cycle (albums))

## TODO:
- Add more admin options (all of the suggested ones except #3, and more)
- A way to close/delete Hearizons
- Better detection of pending reviews (especially if hearizons is unspecified)
- Clean up architecture
- Notify admins when phase is nearly over
- Configuration file
- Notify users when they are assigned a review
- Detect track song + title from URL and use it for display
- Manage roles

Note that the bot currently is capable of handling all three mandatory bullet points.

## Usage
__For admins__:
- Run `/admin hearizons create <name>` to create a new Hearizons. Each Hearizons can have multiple cycles and can be run separately.
- When submissions are over, run `/admin cycle review <name>` to move a Hearizons to the review phase. Assignments will be automatically generated can can be re-randomized if needed, but **you will need to notify players of their assignment manually**.
- When reviews are over, run `/admin cycle advance <name>` to move a Hearizons to the next cycle. Submissions will open again, and users with overdue reviews will not be allowed to submit until they complete their review.

__For players__:
- Run `/submit <track>` to submit a track. If there are multiple Hearizons with submissions open, you'll have to specify which one. This command can also be used to update your submission for a Hearizons by running it again with the updated submission.
- Run `/review` to submit a review for a track you were assigned to. This will then send a message in the reviews post channel, and you will no longer be able to submit a review until the next cycle.


`/ping` can be used to check the bot's connection status.
