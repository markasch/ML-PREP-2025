#  Landslide inventory by machine learning and risk assessment dashboard 

In this directory, we provide supporting material for, and describe a landslide inventory research project, supplemented by a decision-making tool in the form of an interactive dashboard.

- project descriptions and references: 
  - [document](./P1-LandslideInventory.pdf) for the global approach (Inventory + VaR)
  - [document](./P0-benchmark/P0_LandslideInventory.pdf) for an initial exercise based on a Landslide Inventory Benchmark. Please see the dedicated [directory](./P0-benchmark)
- general presentation of Value at Risk (VaR) for environmental applications and dashboard description - [document](./VaR.pdf)
- mathematical presentation of VaR, CVaR and computation methods with applications - [document](./var-cvar.pdf)
- codes for VaR dashboard:
  - `dash`-based - [notebook](./landslide_dash.ipynb)
  - class-based `dash` with static output  - [notebook](./landslide_dash_out.ipynb)
  - `streamlit` version  - [python](./landslide-dashboard.py)
- code for VaR, CVaR computations  - [notebook](./var-cvar-env.ipynb)