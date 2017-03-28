# Usage:

For US English data, enter directory containing `*.wav` and `*.lab` -- the latter just orthographic text prompts -- and run
```
docker run -v $PWD:/data -t psibre/kaldi-mfa bash -c 'cd /data; /mfa/dist/montreal-forced-aligner/bin/mfa_align /mfa/pretrained_models/english.zip . .'
```
This should create corresponding `*.TextGrid` files in this directory.
