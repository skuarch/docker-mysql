#!/bin/bash

service mysql start &
tail -100f /var/log/dmesg
