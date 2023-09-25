# Use CentOS as the base image
FROM centos:7

# Install necessary packages for GUI and VNC server
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y groupinstall "X Window System" "GNOME Desktop" && \
    yum -y install tigervnc-server && \
    yum clean all

# Set root password for VNC server
RUN echo "VNCPASSWD" | vncpasswd -f > /root/.vnc/passwd

# Set permissions for VNC password file
RUN chmod 600 /root/.vnc/passwd

# Expose VNC server port
EXPOSE 5901

# Start VNC server to access CentOS GUI
CMD ["vncserver", ":1", "-geometry", "1280x800", "-fg"]
