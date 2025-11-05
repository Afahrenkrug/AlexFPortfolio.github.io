import pandas as pd
import random
from datetime import datetime, timedelta

# Define sample data pools
types = ["Cash", "Check", "ACH"]
donation_types = [
    "Individual",
    "Private Grants",
    "Government Grants",
    "Church/Religious Organizations",
    "Corporate Donations",
    "Other"
]

individual_names = [
    "Sarah Johnson", "Michael Chen", "Emily Rogers", "James Patel", "Maria Lopez",
    "David Nguyen", "Olivia Brooks", "Robert Thompson", "Ava Martinez", "Liam Anderson",
    "Sophia White", "Isabella Garcia", "Ethan Brown", "Noah Miller", "Mia Davis",
    "Charlotte Wilson", "Lucas Moore", "Amelia Taylor", "Benjamin Lee", "Harper Clark"
]

org_names = {
    "Private Grants": ["Green Future Foundation", "Helping Hands Foundation", "Community Hope Center", "Bright Minds Trust"],
    "Government Grants": ["City of Springfield", "U.S. Department of Education", "State of California", "National Endowment for the Arts"],
    "Church/Religious Organizations": ["St. Mark’s Church", "First Baptist Church", "Bright Horizons Church", "Faith & Hope Ministries"],
    "Corporate Donations": ["GlobalTech Inc.", "Starbridge Corp.", "Tech4Good LLC", "Unity Systems"],
    "Other": ["Neighborhood Fund", "Civic Alliance Group", "Downtown Volunteers", "Springfield Charity Drive"]
}

# Generate random entries
entries = []
start_year = 2025

for _ in range(200):
    month = random.randint(1, 12)
    year = start_year
    type_ = random.choice(types)
    donation_type = random.choice(donation_types)

    # Pick donator name based on donation type
    if donation_type == "Individual":
        donator = random.choice(individual_names)
        amount = round(random.uniform(20, 500), 2)
    else:
        donator = random.choice(org_names[donation_type])
        if donation_type == "Private Grants":
            amount = round(random.uniform(1000, 10000), 2)
        elif donation_type == "Government Grants":
            amount = round(random.uniform(5000, 25000), 2)
        elif donation_type == "Church/Religious Organizations":
            amount = round(random.uniform(500, 3000), 2)
        elif donation_type == "Corporate Donations":
            amount = round(random.uniform(1000, 10000), 2)
        else:
            amount = round(random.uniform(500, 5000), 2)

    # Generate realistic date ranges
    day_received = random.randint(1, 28)
    date_received = datetime(year, month, day_received)
    date_deposited = date_received + timedelta(days=random.randint(0, 3))

    entries.append({
        "Type": type_,
        "Month": date_received.strftime("%B"),
        "Year": year,
        "Date Received": date_received.strftime("%Y-%m-%d"),
        "Date Deposited": date_deposited.strftime("%Y-%m-%d"),
        "Donator": donator,
        "Amount": amount,
        "Donation Type": donation_type
    })

# Convert to DataFrame
df = pd.DataFrame(entries)

# Save to Excel file
excel_path = "sample_donation_deposits_2025.xlsx"
df.to_excel(excel_path, index=False)

print(f"Excel file created: {excel_path}")