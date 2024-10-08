const hyprland = await Service.import("hyprland")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);

const Workspaces = () => Widget.EventBox({
    onScrollUp: () => dispatch('+1'),
    onScrollDown: () => dispatch('-1'),
    child: Widget.Box({
        class_name: "workspaces",
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
            attribute: i,
            label: i.toString(),
            onClicked: () => dispatch(i),
        })),
        setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
            const isFocused = hyprland.active.workspace.id === btn.attribute;
            const isEmpty = !hyprland.workspaces.some(ws => ws.id === btn.attribute);

            btn.class_name = `${isFocused ? "focused" : ""} ${isEmpty ? "empty" : ""}`;
            btn.label = isFocused ? "" : "";
        })),
    }),
})

function truncateLabel(label) {
    return label.slice(0, 70) + `${label.length > 70 ? "..." : ""}`
}

function ClientTitle() {
    return Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client.bind("title").as(label => truncateLabel(label)),
    })
}

const date = Variable("", {
    poll: [1000, 'date "+  %b %e, %Y"'],
})

function Date() {
    return Widget.Label({
        class_name: "date",
        label: date.bind(),
    })
}

const time = Variable("", {
    poll: [1000, 'date "+󰅐  %H:%M:%S"'],
})

function Time() {
    return Widget.Label({
        class_name: "time",
        label: time.bind(),
    })
}



function Media() {
    const label = Utils.watch("", mpris, "player-changed", () => {
        if (mpris.players[0]) {
            const { track_artists, track_title } = mpris.players[0]
            return truncateLabel(`${track_artists.join(", ")} - ${track_title}`)
        } else {
            return "Nothing is playing"
        }
    })

    return Widget.Button({
        class_name: "media",
        on_primary_click: () => mpris.getPlayer("")?.playPause(),
        on_scroll_up: () => mpris.getPlayer("")?.next(),
        on_scroll_down: () => mpris.getPlayer("")?.previous(),
        child: Widget.Label({ label }),
    })
}


function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
    })

    return Widget.Box({
        class_name: "volume",
        css: "min-width: 180px",
        children: [icon, slider],
    })
}


function BatteryLabel() {
    return Widget.Box({
        visible: battery.bind("available"),
        vexpand: true,
        children: [
            Widget.Icon({ icon: battery.bind("icon_name") }),
            Widget.Label({
                class_name: "battery-percentage-label",
                label: battery.bind("percent").as(p => p.toString() + '%'),
            }),
        ],
    })
}


function SysTray() {
    const items = systemtray.bind("items")
    .as(items => items.map(item => Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
    })))

    return Widget.Box({
        children: items,
    })
}

function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            Workspaces(),
            ClientTitle(),
        ],
    })
}

function Center(monitor) {
    return Widget.Box({
        spacing: 8,
        children: monitor === 0 ? [
            Media(),
        ] : [],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            SysTray(),
            Volume(),
            BatteryLabel(),
            Date(),
            Time(),
        ],
    })
}

export function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(monitor),
            end_widget: Right(),
        }),
    })
}
