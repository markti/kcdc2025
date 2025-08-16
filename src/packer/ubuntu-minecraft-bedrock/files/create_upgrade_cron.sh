#!/bin/bash

# Cron job command to run the upgrade script at midnight
CRON_JOB="0 0 * * * /home/mcserver/minecraft_bedrock/upgrade_minecraft.sh"

# Add the cron job to the mcserver user's crontab
(crontab -u mcserver -l; echo "$CRON_JOB") | crontab -u mcserver -