"use babel";

import { CompositeDisposable } from "atom";

const notificationsOptions = { icon: "light-bulb" };
const subscriptions = new CompositeDisposable();

export function lightTheme() {
    return atom.config.get("auto-dark-mode.lightProfile");
}

export function darkTheme() {
    return atom.config.get("auto-dark-mode.darkProfile");
}

export function currentTheme() {
    return atom.config.get("core.themes").join(" ");
}

export function changeTheme(theme = "") {
    atom.config.set("core.themes", theme.split(" "));
}

export function onLight() {
    const lightTheme = this.lightTheme();
    if (this.currentTheme() != lightTheme) {
        this.changeTheme(lightTheme);
        if (atom.config.get("auto-dark-mode.notifyOnChange")) {
            atom.notifications.addSuccess(
                "Auto Dark Mode: Switched to light theme",
                notificationsOptions
            );
        }
    }
}

export function onDark() {
    const darkTheme = this.darkTheme();

    if (this.currentTheme() != darkTheme) {
        this.changeTheme(darkTheme);
        if (atom.config.get("auto-dark-mode.notifyOnChange")) {
            atom.notifications.addSuccess(
                "Auto Dark Mode: Switched to dark theme",
                notificationsOptions
            );
        }
    }
}

export function toggle() {
    const lightTheme = this.lightTheme();
    const darkTheme = this.darkTheme();
    let next = this.currentTheme() == darkTheme ? lightTheme : darkTheme;

    return this.changeTheme(next);
}

export function activate() {
    subscriptions.add(
        atom.commands.add("atom-workspace", {
            "auto-dark-mode:toggle": () => this.toggle(),
        })
    );

    setTimeout(() => {
        if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
            this.changeTheme(this.darkTheme());
        } else {
            this.changeTheme(this.lightTheme());
        }
    }, 50);

    window.matchMedia("(prefers-color-scheme: dark)").addListener((e) => {
        if (e.matches) {
            this.onDark();
        } else {
            this.onLight();
        }
    });
}

export function deactivate() {
    subscriptions.dispose();
}
