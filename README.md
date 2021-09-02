# rclone-backup

Simple directory backup with RClone

## Environment Variables:
| Variable | Required? | Default | Description |
| -------- |:--------- |:------- |:----------- |
| `CRON` | Optional |  | CRON schedule for backup |
| `BACKUP_DIR` | Required |  | Full path to directory to backup |
| `FILE_PREFIX` | Required |  | Directory to backup |
| `DELETE_OLDER_THAN` | Optional | `None` | Optionally, delete files older than `DELETE_OLDER_THAN` (s,m,d,y). Eg: 1d - one day |
| `RCLONE_REMOTE` | Required | `None` | The configured rclone remote mounted from /root |
| `RCLONE_PATH` | Required | `None` | Path in your rclone backup target. Do not put trailing / |


