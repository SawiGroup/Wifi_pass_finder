import subprocess

def find_wifi_password(network_SSID):
    results = subprocess.check_output(["netsh", "wlan", "show", "profile"]).decode("utf-8").split("\n")
    profile_names = [line.split(":")[1][1:-1] for line in results if "All User Profile" in line]
    password = ""
    for name in profile_names:
        profile_info = subprocess.check_output(["netsh", "wlan", "show", "profile", name, "key=clear"]).decode("utf-8").split("\n")
        for line in profile_info:
            if "Key Content" in line:
                password = line.split(":")[1][1:-1]
                break
        if name == network_SSID:
            break
    return password
print password
