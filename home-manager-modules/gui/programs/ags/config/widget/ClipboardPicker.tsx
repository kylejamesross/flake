import { For, createState } from "ags"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import Graphene from "gi://Graphene"

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

function preview(item: string) {
  const text = item.replace(/^\d+\t/, "")
  const oneLine = text.replace(/\s+/g, " ").trim()
  return oneLine.length > 60 ? `${oneLine.slice(0, 60)}…` : oneLine
}

export default function ClipboardPicker() {
  let contentbox: Gtk.Box
  let searchentry: Gtk.Entry
  let win: Astal.Window

  let allItems = new Array<string>()
  let resolve: ((item: string) => void) | null = null
  const [list, setList] = createState(new Array<string>())

  function filter(text: string) {
    const items =
      text === ""
        ? allItems
        : allItems.filter((i) => i.toLowerCase().includes(text.toLowerCase()))
    setList(items.slice(0, 100))
  }

  function open(items: string[], res: (item: string) => void) {
    allItems = items
    resolve = res
    searchentry.set_text("")
    filter("")
    win.visible = true
  }

  function select(item?: string) {
    resolve?.(item ?? "")
    resolve = null
    win.visible = false
  }

  // close on ESC, pick top match on Enter, handle alt + number key
  function onKey(
    _e: Gtk.EventControllerKey,
    keyval: number,
    _: number,
    mod: number,
  ) {
    if (keyval === Gdk.KEY_Escape) {
      select("")
      return
    }

    if (keyval === Gdk.KEY_Return || keyval === Gdk.KEY_KP_Enter) {
      return select(list.get()[0])
    }

    if (mod === Gdk.ModifierType.ALT_MASK) {
      for (const i of [1, 2, 3, 4, 5, 6, 7, 8, 9] as const) {
        if (keyval === Gdk[`KEY_${i}`]) {
          return select(list.get()[i - 1])
        }
      }
    }

    if (mod === Gdk.ModifierType.CONTROL_MASK) {
      if (keyval === Gdk.KEY_y) {
        return select(list.get()[0])
      }
      if (keyval === Gdk.KEY_n) {
        win.child_focus(Gtk.DirectionType.TAB_FORWARD)
        return
      }
      if (keyval === Gdk.KEY_p) {
        win.child_focus(Gtk.DirectionType.TAB_BACKWARD)
        return
      }
    }
  }

  // close on clickaway
  function onClick(_e: Gtk.GestureClick, _: number, x: number, y: number) {
    const [, rect] = contentbox.compute_bounds(win)
    const position = new Graphene.Point({ x, y })

    if (!rect.contains_point(position)) {
      select("")
      return true
    }
  }

  const window = (
    <window
      $={(ref) => (win = ref)}
      name="clipboard-picker"
      anchor={TOP | BOTTOM | LEFT | RIGHT}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      onNotifyVisible={({ visible }) => {
        if (visible) searchentry.grab_focus()
        else searchentry.set_text("")
      }}
    >
      <Gtk.EventControllerKey onKeyPressed={onKey} />
      <Gtk.GestureClick onPressed={onClick} />
      <box
        $={(ref) => (contentbox = ref)}
        name="clipboard-picker-content"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        orientation={Gtk.Orientation.VERTICAL}
      >
        <entry
          $={(ref) => (searchentry = ref)}
          onNotifyText={({ text }) => filter(text)}
          placeholderText="Search clipboard history"
        />
        <Gtk.Separator visible={list((l) => l.length > 0)} />
        <scrolledwindow
          hscrollbarPolicy={Gtk.PolicyType.NEVER}
          maxContentHeight={500}
          propagateNaturalHeight
        >
          <box orientation={Gtk.Orientation.VERTICAL}>
            <For each={list}>
              {(item, index) => (
                <button onClicked={() => select(item)}>
                  <box>
                    <label label={preview(item)} maxWidthChars={40} wrap />
                    <label
                      hexpand
                      halign={Gtk.Align.END}
                      label={index((i) => (i < 9 ? `󰘳 ${i + 1}` : ""))}
                    />
                  </box>
                </button>
              )}
            </For>
          </box>
        </scrolledwindow>
      </box>
    </window>
  ) as Gtk.Window

  return { window, open }
}
