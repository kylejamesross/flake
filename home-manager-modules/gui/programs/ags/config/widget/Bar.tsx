import app from "ags/gtk4/app";
import GLib from "gi://GLib";
import Astal from "gi://Astal?version=4.0";
import Gtk from "gi://Gtk?version=4.0";
import Gdk from "gi://Gdk?version=4.0";
import AstalWp from "gi://AstalWp";
import AstalHyprland from "gi://AstalHyprland";
import AstalTray from "gi://AstalTray";
import AstalMpris from "gi://AstalMpris";
import AstalApps from "gi://AstalApps";
import { For, With, createBinding, createComputed } from "ags";
import { createPoll } from "ags/time";

function Workspaces() {
  const hyprland = AstalHyprland.get_default();
  const focused = createBinding(hyprland, "focused_workspace");

  const workspaces = createComputed(
    [
      createBinding(hyprland, "workspaces"),
      createBinding(hyprland, "focused_workspace"),
    ],
    (workspaces) => {
      const visible = [
        { id: 1 },
        { id: 2 },
        { id: 3 },
        { id: 4 },
        { id: 5 },
        { id: 6 },
        { id: 7 },
        { id: 8 },
        { id: 9 },
      ];

      workspaces
        .sort((a, b) => a.get_id() - b.get_id())
        .filter((ws) => ws.get_id() > visible[visible.length - 1].id)
        .forEach((ws) => visible.push({ id: ws.id }));

      return visible;
    },
  );

  return (
    <box class="workspaces">
      <For each={workspaces}>
        {(workspace) => (
          <button
            widthRequest={44}
            class={focused((focused) =>
              focused.id == workspace.id ? "active" : "inactive",
            )}
            onClicked={() =>
              hyprland.dispatch("workspace", workspace.id.toString())
            }
          >
            <label
              label={focused((focused) =>
                focused.id == workspace.id ? "" : "",
              )}
            />
          </button>
        )}
      </For>
    </box>
  );
}

function FocusedTitle() {
  const hyprland = AstalHyprland.get_default();
  const hyprlandClient = createBinding(hyprland, "focused_client");
  return (
    <box>
      <With value={hyprlandClient}>
        {(client) => (
          <box class="window-title" visible={client?.title.length > 0}>
            <label label={client?.title.slice(0, 70)}></label>
          </box>
        )}
      </With>
      <box />
    </box>
  );
}

function Mpris() {
  const mpris = AstalMpris.get_default();
  const apps = new AstalApps.Apps();
  const players = createBinding(mpris, "players");

  return (
    <menubutton class="mpris">
      <box>
        <For each={players}>
          {(player) => {
            const [app] = apps.exact_query(player.entry);
            return <image visible={!!app.iconName} iconName={app?.iconName} />;
          }}
        </For>
      </box>
      <popover>
        <box spacing={4} orientation={Gtk.Orientation.VERTICAL}>
          <For each={players}>
            {(player) => (
              <box spacing={4} widthRequest={200}>
                <box overflow={Gtk.Overflow.HIDDEN} css="border-radius: 8px;">
                  <image
                    pixelSize={64}
                    file={createBinding(player, "coverArt")}
                  />
                </box>
                <box
                  valign={Gtk.Align.CENTER}
                  orientation={Gtk.Orientation.VERTICAL}
                >
                  <label xalign={0} label={createBinding(player, "title")} />
                  <label xalign={0} label={createBinding(player, "artist")} />
                </box>
                <box hexpand halign={Gtk.Align.END}>
                  <button
                    onClicked={() => player.previous()}
                    visible={createBinding(player, "canGoPrevious")}
                  >
                    <image iconName="media-seek-backward-symbolic" />
                  </button>
                  <button
                    onClicked={() => player.play_pause()}
                    visible={createBinding(player, "canControl")}
                  >
                    <box>
                      <image
                        iconName="media-playback-start-symbolic"
                        visible={createBinding(
                          player,
                          "playbackStatus",
                        )((s) => s === AstalMpris.PlaybackStatus.PLAYING)}
                      />
                      <image
                        iconName="media-playback-pause-symbolic"
                        visible={createBinding(
                          player,
                          "playbackStatus",
                        )((s) => s !== AstalMpris.PlaybackStatus.PLAYING)}
                      />
                    </box>
                  </button>
                  <button
                    onClicked={() => player.next()}
                    visible={createBinding(player, "canGoNext")}
                  >
                    <image iconName="media-seek-forward-symbolic" />
                  </button>
                </box>
              </box>
            )}
          </For>
        </box>
      </popover>
    </menubutton>
  );
}

function Tray() {
  const tray = AstalTray.get_default();
  const items = createBinding(tray, "items");

  const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
    btn.menuModel = item.menuModel;
    btn.insert_action_group("dbusmenu", item.actionGroup);
    item.connect("notify::action-group", () => {
      btn.insert_action_group("dbusmenu", item.actionGroup);
    });
  };

  return (
    <box class="tray">
      <For each={items}>
        {(item) => (
          <menubutton $={(self) => init(self, item)}>
            <image gicon={createBinding(item, "gicon")} />
          </menubutton>
        )}
      </For>
    </box>
  );
}

function AudioOutput() {
  const { defaultSpeaker: speaker } = AstalWp.get_default()!;

  return (
    <menubutton class="audio-output">
      <image iconName={createBinding(speaker, "volumeIcon")} />
      <popover>
        <box>
          <slider
            widthRequest={260}
            onChangeValue={({ value }) => speaker.set_volume(value)}
            value={createBinding(speaker, "volume")}
          />
        </box>
      </popover>
    </menubutton>
  );
}

function Clock({ format = "%H:%M" }) {
  const time = createPoll("", 1000, () => {
    return GLib.DateTime.new_now_local().format(format)!;
  });

  return (
    <menubutton class="clock">
      <label label={time} />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  );
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox>
        <box $type="start">
          <Workspaces />
          <Mpris />
        </box>
        <box $type="center">
          <FocusedTitle />
        </box>
        <box $type="end">
          <Tray />
          <AudioOutput />
          <Clock />
        </box>
      </centerbox>
    </window>
  );
}
