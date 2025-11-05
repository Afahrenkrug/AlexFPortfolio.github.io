import pandas as pd
import random
from datetime import datetime, timedelta

# Define sample data pools
types = ["Cash", "Check", "ACH"]

# Define invoice types
invoice_types = [
    "Agency Development",
    "Fundraising",
    "Guest Services",
    "Other"
]

#
agency_types = [
    "Utilities", "Maintenance", "Supplies"
]

fundraising_types = [
    "Summer At The Beach", "Christmas Gifts", "The Season Of Giving"
]

guest_services_types = [
    "Transportation", "Hotel Fees", "Meals", "Recreational"
]

other_types = [
    "Payroll", "Insurance", "Mailing", "Regular Fees"
]

# Generate random entries
entries = []
start_year = 2025

for _ in range(200):
    month = random.randint(1, 12)
    year = start_year
    type_ = random.choice(types)
    invoice_type = random.choice(invoice_types)

    # Pick donator name based on donation type
    if invoice_type == "Agency Development":
        invoice = random.choice(agency_types)
        amount = round(random.uniform(20, 500), 2)
    if invoice_type == "Fundraising":
        invoice = random.choice(fundraising_types)
        amount = round(random.uniform(1000, 10000), 2)
    if invoice_type == "Guest Services":
        invoice = random.choice(guest_services_types)
        amount = round(random.uniform(5000, 25000), 2)
    else:
        invoice = random.choice(other_types)
        amount = round(random.uniform(500, 5000), 2)

    # Generate realistic date ranges
    day_received = random.randint(1, 28)
    date_received = datetime(year, month, day_received)
    date_deposited = date_received + timedelta(days=random.randint(0, 3))

    entries.append({
        "Type": type_,
        "Month": date_received.strftime("%B"),
        "Year": year,
        "Amount": amount,
        "Invoice Type": invoice_type
    })

# Convert to DataFrame
df = pd.DataFrame(entries)

# Save to Excel file
excel_path = "sample_invoices_data_2025.xlsx"
df.to_excel(excel_path, index=False)

print(f"Excel file created: {excel_path}")