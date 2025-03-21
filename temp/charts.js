
    // Fetch the data generated by data.jsp
    fetch('data.jsp')
        .then(response => response.json())
        .then(data => {
            // Check if the data key exists
            if (!data.data) {
                console.error("Error: Data not found in the response");
                return;
            }

            // Log the fetched data for debugging
            console.log("Fetched data:", data.data);

            // Extract data for the chart
            const departmentNames = data.data.map(item => item.departmentName);
            const totalLogCredits = data.data.map(item => item.totalLogCredit);
            const avgLogCredits = data.data.map(item => item.avgLogCredit);

            // Log the extracted data for debugging
            console.log("Department Names:", departmentNames);
            console.log("Total Log Credits:", totalLogCredits);
            console.log("Average Log Credits:", avgLogCredits);

            // Render the chart
            new Chart(document.getElementById("myChart"), {
                type: "bar",  // Change to 'line', 'pie', etc., as needed
                data: {
                    labels: departmentNames,
                    datasets: [
                        {
                            label: "Total Log Credits",
                            data: totalLogCredits,
                            backgroundColor: "rgba(75, 192, 192, 0.2)",
                            borderColor: "rgba(75, 192, 192, 1)",
                            borderWidth: 1
                        },
                        {
                            label: "Average Log Credits",
                            data: avgLogCredits,
                            backgroundColor: "rgba(192, 75, 192, 0.2)",
                            borderColor: "rgba(192, 75, 192, 1)",
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error("Error fetching data:", error);
        });
