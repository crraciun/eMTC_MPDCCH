import uhd
def recv_to_file():
    """RX samples and write to file"""
    usrp = uhd.usrp.MultiUSRP("type=b200")
    num_samps = 1e6
    if not isinstance(args.channels, list):
        args.channels = [args.channels]
    samps = usrp.recv_num_samps(
        1e6, # Number of samples
        2.4e9, # Frequency in Hz
        1e6, # Sampling rate
        [0], # Receive on channel 0
        80, # 80 dB of RX gain
    )
    samps.tofile('samples.dat')
