import React, { useEffect, useRef } from 'react';
import Chart from 'chart.js/auto';
import {
  PolarAreaController,
  RadialLinearScale,
  ArcElement,
  Tooltip,
  Legend,
} from 'chart.js';

Chart.register(PolarAreaController, RadialLinearScale, ArcElement, Tooltip, Legend);

interface UserCounts{
    studentCount:number,
    teacherCount:number,
    parentCount:number,
    staffCount:number,

}

interface SchoolFees{
  allCount: number;
  pendingCount: number;
  successfulCount: number;
  declinedCount: number;
}

export const UsersChart = ({studentCount, teacherCount, parentCount, staffCount}:UserCounts) =>{
  const chartRef = useRef<HTMLCanvasElement | null>(null)
  const myChartRef = useRef<Chart | null>(null)


  useEffect(() =>{
    if(myChartRef.current){
       myChartRef.current.destroy();
    }


    // Define the data for the chart
    const data = {
      labels: ['Student', 'Teacher', 'Parent', 'Staff'],
      datasets: [
        {
          label: 'Users Counts',
          data: [studentCount, teacherCount,  parentCount, staffCount],
          backgroundColor: [
            'rgba(120, 62, 188, 0.6)',  // primary-color
            'rgba(65, 74, 202, 0.6)',   // secondary-color
            'rgba(38, 142, 192, 0.6)',  // support-color
            'rgba(47, 179, 122, 0.6)',  // new teal
          ],
          borderColor: [
            'rgba(120, 62, 188, 1)',
            'rgba(65, 74, 202, 1)',
            'rgba(38, 142, 192, 1)',
            'rgba(47, 179, 122, 1)',
          ],
          
          borderWidth: 1,
        },
      ],
    };

    const options = {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true,
        },
      },
    };

    // Create the chart instance
    if (chartRef.current) {
      myChartRef.current = new Chart(chartRef.current, {
        type: 'bar',
        data: data,
        options: options,
      });
    }

    // Cleanup to avoid memory leaks
    return () => {
      if (myChartRef.current) {
        myChartRef.current.destroy();
      }
    };
  }, [studentCount, teacherCount,  parentCount, staffCount])

  return (
    <div style={{ width: '100%', height: '200px' }}>
      <canvas ref={chartRef} />
    </div>
  );
}



export const SchoolFeesChart = ({
  allCount,
  pendingCount,
  successfulCount,
  declinedCount,
}: SchoolFees) => {
  const chartRef = useRef<HTMLCanvasElement | null>(null);
  const myChartRef = useRef<Chart | null>(null);

  useEffect(() => {
    if (myChartRef.current) {
      myChartRef.current.destroy();
    }

    const data = {
      labels: ['Pending', 'Successful', 'Declined'],
      datasets: [
        {
          label: 'Status Counts',
          data: [allCount, pendingCount, successfulCount, declinedCount],
          backgroundColor: [
            'rgb(201, 203, 207)',
            'rgba(255, 206, 86, 0.6)',  // Yellowish for pending
            'rgba(75, 192, 192, 0.6)',  // Greenish for success
            'rgba(255, 99, 132, 0.6)',  // Reddish for declined
          ],
          borderColor: [
            'rgb(160, 160, 160)',
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(255, 99, 132, 1)',
          ],
          borderWidth: 1,
        },
      ],
    };

    const options = {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'top' as const,
        },
      },
    };

    if (chartRef.current) {
      myChartRef.current = new Chart(chartRef.current, {
        type: 'polarArea',
        data: data,
        options: options,
      });
    }

    return () => {
      if (myChartRef.current) {
        myChartRef.current.destroy();
      }
    };
  }, [pendingCount, successfulCount, declinedCount]);

  return (
    <div style={{ width: '100%', height: '300px' }}>
      <canvas ref={chartRef} />
    </div>
  );
};