#!/bin/bash

doom clean &&
	doom -y upgrade &&
	doom upgrade &&
	doom purge &&
	doom sync &&
	doom build
