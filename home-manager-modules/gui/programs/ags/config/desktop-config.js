import { Bar } from './config.js';
import { NotificationPopups } from "./notificationPopups.js"
import { applauncher } from "./applauncher.js"

App.config({
    style: "./style.css",
    windows: [
        Bar(0),
        Bar(1),
        Bar(2),
        NotificationPopups(),
        applauncher,
    ],
})
