# AutoLog
Enable combatlog in raid and mythic+ dungeons automatically.

### Why use `ZONE_CHANGED_NEW_AREA` to trigger
It's more appropriate to use `CHALLENGE_MODE_START` and `CHALLENGE_MODE_COMPLETED`. But using `CHALLENGE_MODE_START` to initiate combat logging may result in missing initial equipment gear and talent specialization records in log, so use `ZONE_CHANGED_NEW_AREA` to detect when player entered a specific dungeon in 5man mythic mode and then start combat logging.
