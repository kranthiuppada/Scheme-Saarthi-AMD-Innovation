#!/bin/bash
# Quick test script for this Scheme Saarthi backend APIs

BACKEND_URL="http://localhost:5000"

echo "=========================================="
echo "🧪 Testing Scheme Saarthi Backend APIs"
echo "=========================================="

# Test 1: Health Check
echo ""
echo "1️⃣  Testing Health Check..."
curl -s $BACKEND_URL/health | python -m json.tool

# Test 2: Get All Schemes
echo ""
echo "2️⃣  Testing Get All Schemes..."
curl -s $BACKEND_URL/api/schemes | python -m json.tool | head -50

# Test 3: Get Scheme by ID
echo ""
echo "3️⃣  Testing Get Scheme by ID (PM-KISAN)..."
curl -s $BACKEND_URL/api/schemes/PM-KISAN | python -m json.tool

# Test 4: Search Schemes (Farmer, Age 45)
echo ""
echo "4️⃣  Testing Search Schemes (Farmer eligibility)..."
curl -s -X POST $BACKEND_URL/api/schemes/search \
  -H "Content-Type: application/json" \
  -d '{
    "age": 45,
    "occupation": "farmer",
    "income": 100000
  }' | python -m json.tool

# Test 5: Create Citizen
echo ""
echo "5️⃣  Testing Create Citizen..."
curl -s -X POST $BACKEND_URL/api/citizens \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "+919876543210",
    "name": "Ramesh Kumar",
    "age": 45,
    "gender": "Male",
    "occupation": "farmer",
    "annual_income": 100000,
    "state": "Andhra Pradesh",
    "district": "Guntur",
    "language_preference": "Telugu"
  }' | python -m json.tool

# Test 6: Get Citizen by Phone
echo ""
echo "6️⃣  Testing Get Citizen by Phone..."
curl -s $BACKEND_URL/api/citizens/phone/+919876543210 | python -m json.tool

# Test 7: Check Eligibility
echo ""
echo "7️⃣  Testing Check Eligibility..."
curl -s -X POST $BACKEND_URL/api/applications/check-eligibility \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "+919876543210"
  }' | python -m json.tool

# Test 8: Create Application
echo ""
echo "8️⃣  Testing Create Application..."
curl -s -X POST $BACKEND_URL/api/applications \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "+919876543210",
    "scheme_id": "PM-KISAN",
    "documents_submitted": ["aadhaar", "land_records"],
    "status": "draft"
  }' | python -m json.tool

# Test 9: Get Applications by Phone
echo ""
echo "9️⃣  Testing Get Applications by Phone..."
curl -s $BACKEND_URL/api/applications/phone/+919876543210 | python -m json.tool

echo ""
echo "=========================================="
echo "✅ All tests completed!"
echo "=========================================="
