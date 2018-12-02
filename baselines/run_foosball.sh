#!/usr/bin/env bash

for seed in $(seq 0 2); do
  OPENAI_LOG_FORMAT=csv,log,stdout \
  OPENAI_LOGDIR=logs/foosball-ppo-hp/b512-$seed \
  nohup ./xvfb-run-safe -s "-screen 0 800x600x24" python3 -m baselines.run \
    --alg=ppo2 \
    --env=Foosball_sp-v0 \
    --network=mlp \
    --num_timesteps=1e7 \
    --num_env=2 \
    --seed=$seed \
    --nsteps=512 \
    --num_hidden=256 \
    --num_layers=4 \
    --value_network=copy \
    --save_path=models/foosball/b512/foosball1M_ppo2 > foosball_512_$seed.out & disown;
done

for seed in $(seq 0 2); do
  OPENAI_LOG_FORMAT=csv,log,stdout \
  OPENAI_LOGDIR=logs/foosball-ppo-hp/b1024-$seed \
  nohup ./xvfb-run-safe -s "-screen 0 800x600x24" python3 -m baselines.run \
    --alg=ppo2 \
    --env=Foosball_sp-v0 \
    --network=mlp \
    --num_timesteps=1e7 \
    --num_env=2 \
    --seed=$seed \
    --nsteps=1024 \
    --num_hidden=256 \
    --num_layers=4 \
    --value_network=copy \
    --save_path=models/foosball/b1024/foosball1M_ppo2 > foosball_1024_$seed.out & disown;
done
