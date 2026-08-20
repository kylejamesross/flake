import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget/Bar";
import Applauncher from "./widget/Applauncher";
import ClipboardPicker from "./widget/ClipboardPicker";
import NotificationPopups from "./widget/NotificationPopups";
import Gtk from "gi://Gtk?version=4.0";

let clipboardPicker: ReturnType<typeof ClipboardPicker>;

app.start({
  css: style,
  requestHandler(argv, res) {
    const [command, payload] = argv;

    if (command === "clipboard-pick") {
      const items = (payload ?? "").split("\n").filter((line) => line !== "");
      clipboardPicker.open(items, res);
    } else {
      res(`unknown request: ${command}`);
    }
  },
  main() {
    clipboardPicker = ClipboardPicker();
    app.add_window(clipboardPicker.window);

    app.get_monitors().forEach((monitor) => {
      Bar(monitor);

      app.add_window(Applauncher() as Gtk.Window);

      NotificationPopups();
    });
  },
});
