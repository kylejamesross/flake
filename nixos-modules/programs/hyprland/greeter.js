const greetd = await Service.import('greetd');

const nameField = Widget.Entry({
    placeholder_text: 'Username',
    on_accept: () => passwordField.grab_focus(),
})

const onAccept = () => {
    greetd.login(nameField.text || '', passwordField.text || '', 'Hyprland')
        .catch(() => response.label = "Login Failed. Please enter correct credentials.")
};

const passwordField = Widget.Entry({
    placeholder_text: 'Password',
    visibility: false,
    on_accept: onAccept,
})

const response = Widget.Label()

const loginLabel = Widget.Label({
    className: 'login-label',
    label: 'Log In',
    justification: 'center',
    truncate: 'end',
    xalign: 2,
    maxWidthChars: 24,
    wrap: true,
    useMarkup: true,
})

const loginButton = Widget.Button({
    child: Widget.Label('Login'),
    onClicked: onAccept,
})

const login = Widget.Box({
    className: 'login',
    spacing: 8,
    homogeneous: false,
    vertical: true,
    children: [
        loginLabel,
        nameField,
        passwordField,
        loginButton,
        response,
    ]
})

const win = Widget.Window({
    css: '',
    className: 'window',
    name: 'login',
    setup: self => self.keybind("Escape", () => {
        App.closeWindow('login')
    }),
    keymode: "exclusive",
    anchor: ['top', 'left', 'right', 'bottom'],
    child: Widget.Box({
        vertical: true,
        hpack: 'center',
        vpack: 'center',
        hexpand: true,
        vexpand: true,
        children: [
            login
        ],
    }),
})

App.config({ 
    windows: [win], 
    style: './style.css'
})
