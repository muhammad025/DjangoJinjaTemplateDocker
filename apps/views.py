from django.shortcuts import render

# Create your views here.


from django.shortcuts import render

def home(request):
    context = {
        "name": "Muhammad",
        "age": 20,
        "students": ["Ali", "Vali", "Hasan"],
    }

    return render(request, "home.html", context)