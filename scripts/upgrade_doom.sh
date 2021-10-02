#!/bin/bash

doom clean &&
	doom -y upgrade &&
	doom upgrade &&
	doom sync &&
	doom purge &&
	doom build
