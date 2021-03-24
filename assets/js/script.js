// Problem 1

fetch('../../json/team_run.json')
.then(function(response) {
    return response.json();
})
.then(function (obj){
    let v = Object.entries(obj);
    const chart1 = new Highcharts.Chart({
        chart: {
            renderTo: 'problem1',
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 15,
                beta: 15,
                depth: 50,
                viewDistance: 25
            }
        },
        title: {
            text: 'Total runs scored by team'
        },
        xAxis:{
            type: 'category'
        },
        plotOptions: {
            column: {
                depth: 25
            }
        },
        series: [{
            name: 'Runs',
            data: v
        }]
    });
})
.catch(function(error){
    console.log('Something went wrong');
    console.error(error);
});

// Problem 2

fetch('../../json/rcb_run.json')
.then(function(response) {
    return response.json();
})
.then(function (obj){
    let v = Object.entries(obj);
    // Set up the chart
    const chart2 = new Highcharts.Chart({
        chart: {
            renderTo: 'problem2',
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 15,
                beta: 15,
                depth: 50,
                viewDistance: 25
            }
        },
        title: {
            text: 'Top batsman for Royal Challengers Bangalore'
        },
        xAxis:{
            type: 'category'
        },
        plotOptions: {
            column: {
                depth: 25
            }
        },
        series: [{
            name: 'Runs',
            data: v
        }]
    });
})
.catch(function(error){
    console.log('Something went wrong');
    console.error(error);
});

// Problem 3

fetch('../../json/total_ump_from_country.json')
.then(function(response) {
    return response.json();
})
.then(function (obj){
    let v = Object.entries(obj);
    // Set up the chart
    const chart3 = new Highcharts.Chart({
        chart: {
            renderTo: 'problem3',
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 15,
                beta: 15,
                depth: 50,
                viewDistance: 25
            }
        },
        title: {
            text: 'Foreign umpire analysis'
        },
        xAxis:{
            type:'category'
        },
        plotOptions: {
            column: {
                depth: 25
            }
        },
        series: [{
            name: 'Umpires from Cou',
            data: v
        }]
    });
})
.catch(function(error){
    console.log('Something went wrong');
    console.error(error);
});


// Problem 3

fetch('../../json/team_details.json')
.then(function(response) {
    return response.json();
})
.then(function (obj){
    // Set up the chart
    var seriesm = [];
    let season = ['2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017']
    for (let i in obj){
        seriesm.push({
            name: i,
            data: obj[i]
        });
    }
    console.log(seriesm);
    // Set up the chart
    const chart4 = new Highcharts.chart('problem4', {
        chart: {
          type: 'column'
        },
        title: {
          text: 'Stacked/Grouped chart of matches played by team by season'
        },
        subtitle: {
          text: 'Number of games played by team by season'
        },
        xAxis: {
          categories: season
        },
        yAxis: {
          min: 0,
          title: {
            text: 'Runs'
          }
        },
        tooltip: {
          headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.0f} </b></td></tr>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true
        },
        plotOptions: {
          column: {
            pointPadding: 0.2,
            borderWidth: 0
          }
        },
        series: seriesm
      });
})
.catch(function(error){
    console.log('Something went wrong');
    console.error(error);
});


