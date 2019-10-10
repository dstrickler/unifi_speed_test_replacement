# unifi_speed_test_replacement
Allows you to add your own speed test to be displayed in the Unifi Controller UI.
Assuming your Unifi USG3 is at 10.0.1.1 and you've replaced your username in the top of the bash file, give it a run and see if you see the speed text numbers update on your mobile app. 

All it's doing is running "speedtest" and outputting the resutls to JSON. Then it parseses those results and uploads, via "scp" to the Unifi USG3, replacing files that would normaly be replaced with the normally running speed test on the USG3.

I run this from a RaspberryPi 4 with a 1GB ethernet port. It's run every 10 minutes to give me a good log of the max speeds my Fios line can run.

Note:
1. You need to install "bc" and "speedtest-cli" commands if you are running Ubuntu (only tested with Ubuntu)
2. You need to turn OFF the speed test on the Unifi USG3. If you leave it on, it will overwrite the results with it's own lackluster test.
3. The speeds and test time will update fine on the mobile app, but do not update on the browser version. This is a bug I need to investigate.
