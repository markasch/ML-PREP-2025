import streamlit as st
import pandas as pd
import numpy as np
import plotly.graph_objects as go
import plotly.express as px
import math

# Set page configuration
st.set_page_config(
    page_title="Landslide Risk Assessment Dashboard",
    layout="wide"
)

# Title and description
st.title("Landslide Risk Assessment Dashboard")

# Define sample data for different regions (directly translated from the TS version)
region_data = {
    'Region A': {
        'populationDensity': 1200,
        'infrastructureValue': 45000000,
        'annualIncome': 38000,
        'landValue': 2500,
        'historicalEvents': 12,
        'slope': 32,
        'vegetation': 'Low',
        'rainfall': 'High'
    },
    'Region B': {
        'populationDensity': 850,
        'infrastructureValue': 32000000,
        'annualIncome': 42000,
        'landValue': 3200,
        'historicalEvents': 8,
        'slope': 28,
        'vegetation': 'Medium',
        'rainfall': 'Medium'
    },
    'Region C': {
        'populationDensity': 1800,
        'infrastructureValue': 67000000,
        'annualIncome': 35000,
        'landValue': 4100,
        'historicalEvents': 17,
        'slope': 38,
        'vegetation': 'Very Low',
        'rainfall': 'Very High'
    }
}

# Define function to calculate VaR (directly translated from the TS version)
def calculate_var(confidence, region, horizon, budget):
    region_info = region_data[region]
    
    # Risk factors based on region characteristics
    population_risk = region_info['populationDensity'] / 1000
    slope_risk = region_info['slope'] / 40
    vegetation_mapping = {'Very Low': 0.9, 'Low': 0.7, 'Medium': 0.5, 'High': 0.3, 'Very High': 0.1}
    rainfall_mapping = {'Very Low': 0.1, 'Low': 0.3, 'Medium': 0.5, 'High': 0.7, 'Very High': 0.9}
    
    vegetation_factor = vegetation_mapping[region_info['vegetation']]
    rainfall_factor = rainfall_mapping[region_info['rainfall']]
    historical_factor = min(1, region_info['historicalEvents'] / 20)
    
    # Combined risk score (0-1)
    base_risk_score = (population_risk * 0.2 + slope_risk * 0.25 + 
                        vegetation_factor * 0.2 + rainfall_factor * 0.25 + 
                        historical_factor * 0.1)
    
    # Adjust risk based on confidence level
    # Higher confidence means considering more extreme scenarios
    confidence_adjustment = (confidence - 50) / 50
    adjusted_risk = base_risk_score * (1 + confidence_adjustment * 0.5)
    
    # Scale by time horizon (risk increases with longer time periods)
    # Using a sublinear function to account for mitigation measures over time
    time_adjusted_risk = adjusted_risk * math.pow(horizon, 0.7)
    
    # Impact calculations
    casualties = round(region_info['populationDensity'] * time_adjusted_risk * 0.01 * horizon / 10)
    infrastructure_loss = region_info['infrastructureValue'] * time_adjusted_risk * 0.2
    land_area_lost = 1000 * time_adjusted_risk  # in hectares
    land_value_loss = land_area_lost * region_info['landValue']
    income_loss = region_info['annualIncome'] * casualties * 5  # Assuming 5 years of income loss per casualty
    displacement_count = round(region_info['populationDensity'] * time_adjusted_risk * 0.1)
    displacement_cost = displacement_count * 25000  # Cost per displaced person
    
    total_economic_impact = infrastructure_loss + land_value_loss + income_loss + displacement_cost
    
    # Calculate how mitigation budget would reduce impacts
    mitigation_effectiveness = min(0.8, budget / (total_economic_impact * 0.5))
    mitigated_total_impact = total_economic_impact * (1 - mitigation_effectiveness)
    mitigated_casualties = casualties * (1 - mitigation_effectiveness * 0.9)  # Higher effectiveness for human safety
    
    cost_breakdown = [
        {'name': 'Infrastructure', 'value': infrastructure_loss},
        {'name': 'Land Value', 'value': land_value_loss},
        {'name': 'Income Loss', 'value': income_loss},
        {'name': 'Displacement', 'value': displacement_cost}
    ]
    
    # Calculate ROI (Return on Investment) for mitigation
    mitigation_roi = (total_economic_impact - mitigated_total_impact) / budget if budget > 0 else 0
    
    return {
        'probability': min(0.99, time_adjusted_risk),
        'casualties': round(casualties),
        'mitigatedCasualties': round(mitigated_casualties),
        'infrastructureLoss': infrastructure_loss,
        'landAreaLost': land_area_lost,
        'landValueLoss': land_value_loss,
        'incomeLoss': income_loss,
        'displacementCount': displacement_count,
        'displacementCost': displacement_cost,
        'totalEconomicImpact': total_economic_impact,
        'mitigatedEconomicImpact': mitigated_total_impact,
        'returnPeriod': round(1 / min(0.99, time_adjusted_risk)),
        'costBreakdown': cost_breakdown,
        'mitigationROI': mitigation_roi
    }

# Format currency
def format_currency(value):
    return f"${int(value):,}"

# Create the sidebar controls
st.sidebar.header("Risk Assessment Parameters")

# Control for confidence level
confidence_level = st.sidebar.slider(
    "Risk Confidence Level (%)",
    min_value=50,
    max_value=99,
    value=95,
    help="Higher values represent more conservative risk estimates"
)

# Control for region selection
region_selected = st.sidebar.selectbox(
    "Region",
    options=list(region_data.keys())
)

# Control for time horizon
time_horizon = st.sidebar.slider(
    "Time Horizon (Years)",
    min_value=1,
    max_value=50,
    value=10
)

# Control for mitigation budget
mitigation_budget = st.sidebar.slider(
    "Mitigation Budget",
    min_value=0,
    max_value=10000000,
    value=5000000,
    step=500000,
    format="$%d"
)

# Calculate VaR with the current parameters
var_results = calculate_var(confidence_level, region_selected, time_horizon, mitigation_budget)

# Generate VaR curve data (how VaR changes with confidence level)
var_curve_data = []
for conf_level in range(50, 100, 5):
    result = calculate_var(conf_level, region_selected, time_horizon, mitigation_budget)
    var_curve_data.append({
        'confidenceLevel': conf_level,
        'economicImpact': result['totalEconomicImpact'] / 1000000,
        'casualties': result['casualties']
    })

var_curve_df = pd.DataFrame(var_curve_data)

# Generate mitigation effect data
mitigation_data = []
for budget in range(0, 10000001, 1000000):
    result = calculate_var(confidence_level, region_selected, time_horizon, budget)
    mitigation_data.append({
        'budget': budget / 1000000,
        'impact': result['mitigatedEconomicImpact'] / 1000000,
        'casualties': result['mitigatedCasualties'],
        'roi': result['mitigationROI']
    })

mitigation_df = pd.DataFrame(mitigation_data)

# Create a layout with key metrics
st.header("Key Risk Metrics")
col1, col2, col3, col4 = st.columns(4)

with col1:
    st.subheader("Value at Risk (VaR)")
    st.markdown(f"<h2 style='color:red'>{format_currency(var_results['totalEconomicImpact'])}</h2>", unsafe_allow_html=True)
    st.write(f"at {confidence_level}% confidence over {time_horizon} years")
    st.write(f"Probability: {(var_results['probability'] * 100):.1f}% | Return period: 1 in {var_results['returnPeriod']} years")

with col2:
    st.subheader("Estimated Casualties")
    st.markdown(f"<h2 style='color:red'>{var_results['casualties']}</h2>", unsafe_allow_html=True)
    st.write(f"With mitigation: {var_results['mitigatedCasualties']}")
    st.write(f"Displaced persons: {var_results['displacementCount']:,}")

with col3:
    st.subheader("Land Impact")
    st.markdown(f"<h2 style='color:#FFA500'>{var_results['landAreaLost']:.1f} ha</h2>", unsafe_allow_html=True)
    st.write(f"Value: {format_currency(var_results['landValueLoss'])}")

with col4:
    st.subheader("Mitigation ROI")
    st.markdown(f"<h2 style='color:green'>{var_results['mitigationROI']:.2f}x</h2>", unsafe_allow_html=True)
    st.write(f"Risk reduced by {(var_results['mitigationROI'] * 100):.0f}%")

# Create charts
st.header("Risk Analysis")
col1, col2 = st.columns(2)

with col1:
    st.subheader("Value at Risk by Confidence Level")
    
    fig = px.line(
        var_curve_df, 
        x='confidenceLevel', 
        y='economicImpact',
        labels={
            'confidenceLevel': 'Confidence Level (%)',
            'economicImpact': 'Impact (Millions $)'
        }
    )
    
    fig.update_layout(
        xaxis_title='Confidence Level (%)',
        yaxis_title='Impact (Millions $)'
    )
    
    st.plotly_chart(fig, use_container_width=True)

with col2:
    st.subheader("Impact Breakdown")
    
    # Create a dataframe for the pie chart
    cost_breakdown_df = pd.DataFrame(var_results['costBreakdown'])
    
    fig = px.pie(
        cost_breakdown_df,
        names='name',
        values='value',
        title='Cost Distribution'
    )
    
    st.plotly_chart(fig, use_container_width=True)
    
    # Display cost breakdown
    st.write("Cost Categories:")
    for item in var_results['costBreakdown']:
        st.write(f"{item['name']}: {format_currency(item['value'])}")
    
    st.write(f"**Total: {format_currency(var_results['totalEconomicImpact'])}**")
    st.write(f"**With Mitigation: {format_currency(var_results['mitigatedEconomicImpact'])}**")

# Mitigation Analysis
st.header("Mitigation Budget Analysis")

# Create a figure with two y-axes
fig = go.Figure()

# Add traces
fig.add_trace(
    go.Scatter(
        x=mitigation_df['budget'],
        y=mitigation_df['impact'],
        name='Residual Economic Impact',
        line=dict(color='#ff7300')
    )
)

fig.add_trace(
    go.Scatter(
        x=mitigation_df['budget'],
        y=mitigation_df['roi'],
        name='Return on Investment',
        line=dict(color='#387908'),
        yaxis='y2'
    )
)

# Update layout for dual y-axes
fig.update_layout(
    xaxis=dict(
        title='Mitigation Budget (Millions $)'
    ),
    yaxis=dict(
        title='Residual Impact (Millions $)',
        #titlefont=dict(color='#ff7300'),
        tickfont=dict(color='#ff7300')
    ),
    yaxis2=dict(
        title='ROI',
        #titlefont=dict(color='#387908'),
        tickfont=dict(color='#387908'),
        anchor="x",
        overlaying="y",
        side="right"
    ),
    legend=dict( x=0.85, y=0.90, orientation='v')
        #x=0.01,
        #y=0.99
    #)
)

st.plotly_chart(fig, use_container_width=True)

# Region Details
st.header(f"Region Details: {region_selected}")

col1, col2, col3, col4 = st.columns(4)
with col1:
    st.write("**Population Density**")
    st.write(f"{region_data[region_selected]['populationDensity']} per km²")
    
    st.write("**Historical Events**")
    st.write(f"{region_data[region_selected]['historicalEvents']} incidents")

with col2:
    st.write("**Infrastructure Value**")
    st.write(f"{format_currency(region_data[region_selected]['infrastructureValue'])}")
    
    st.write("**Average Slope**")
    st.write(f"{region_data[region_selected]['slope']}°")

with col3:
    st.write("**Annual Income per Capita**")
    st.write(f"{format_currency(region_data[region_selected]['annualIncome'])}")
    
    st.write("**Vegetation Cover**")
    st.write(f"{region_data[region_selected]['vegetation']}")

with col4:
    st.write("**Land Value**")
    st.write(f"{format_currency(region_data[region_selected]['landValue'])}/ha")
    
    st.write("**Rainfall Intensity**")
    st.write(f"{region_data[region_selected]['rainfall']}")

# Add an explanation section
st.header("About This Dashboard")
st.write("""
This dashboard provides a Value at Risk (VaR) assessment for landslide hazards in different regions. 
The model incorporates various risk factors such as population density, slope gradient, vegetation cover, 
rainfall intensity, and historical landslide incidents to estimate potential economic and human impacts.

Use the controls on the left to adjust the confidence level, select different regions, set the time horizon, 
and allocate mitigation budget to see how these factors affect the overall risk profile.
""")

# Add supplementary information at the bottom
st.markdown("---")
st.caption("Note: This is a simulation based on theoretical models and sample data. For actual risk assessment, consult with geological and disaster management experts.")
