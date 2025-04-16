# lidarutils

To run these utils from the command line, three quick phases are used:

1. Initial setup
1. Connect sensor and test
1. Save and record lidar data


## Initial setup
1. Create a new conda environment: `conda create -n ouster python=3.11`
1. Activate new environment: `conda activate ouster`
1. Install Ouster SDK: `pip3 install ouster-sdk`

To run these commands all at once, run `initial_setup.sh`

## Connect sensor and test

Activate the conda environment (if not already active)

```conda activate ouster```

Test visualization:

```ouster-cli source 192.168.0.101 viz```


## Save the Lidar data

run the command `./doit.sh`


## Checking the data

```ouster-cli source PATH_TO_PCAP_FILE viz```

