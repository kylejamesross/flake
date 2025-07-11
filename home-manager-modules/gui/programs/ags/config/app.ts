import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget/Bar";
import Applauncher from "./widget/Applauncher";
import NotificationPopups from "./widget/NotificationPopups";
import Gtk from "gi://Gtk?version=4.0";

app.start({
  css: style,
  main() {
    app.get_monitors().forEach((monitor) => {
      Bar(monitor);

      app.add_window(Applauncher() as Gtk.Window);

      NotificationPopups();
    });
  },
});
