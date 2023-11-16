## Sending Rsyslog Logs to Graylog

### Modifying the rsyslog.conf file

1. Access your host.
2. Edit the rsyslog.conf file using the command:
   ```bash
   nano /etc/rsyslog.conf
   ```
3. Add the following line at the end of the file:
   - Use a single @ for UDP and two @@ for TCP.
   ```bash
   @Graylog_IP:1516;RSYSLOG_SyslogProtocol23Format
   ```

   **Info:**
   - `*.*` indicates sending all syslog logs to the server.
   - `@Graylog_IP:1516` indicates the Graylog server address and port.
   - `RSYSLOG_SyslogProtocol23Format` is the format of logs sent to Graylog.
   - The Graylog server's IP address must be static.

4. Save the changes and exit.

### Restarting Rsyslog

1. Restart Rsyslog to apply the changes:
   ```bash
   systemctl restart rsyslog.service
   ```

2. Ensure that the service is running correctly:
   ```bash
   systemctl status rsyslog.service
   ```

### Configuring Graylog

1. Access your Graylog server interface via your browser:
   ```bash
   http://Your_graylog_server_IP:9000
   ```

2. Click on "System," then "Inputs."

3. Select "Syslog UDP" from the dropdown and click "Launch new input."

4. Select the "node" and give a name to the input (in the "Title" field).

5. Specify the log port (port 1516 in our example).

6. Confirm and click "Start input."

7. Graylog will start receiving messages from your server.

8. To filter logs, create a stream:
   - Click on "Stream" in the main menu.
   - Click "Create stream" and provide a name and description.
   - Leave the default index.

9. Create a rule to display logs only from the specified source:
   - Click "Manage Rules" then "Add stream Rule."
   - In the "Field" field, type "gl2_source_input."
   - Choose "match exactly" in the "Type" field.
   - Add the value of the gl2_source_input variable.

10. Save the changes.

11. Select the created stream from the dropdown on Graylog's homepage to view the logs.
