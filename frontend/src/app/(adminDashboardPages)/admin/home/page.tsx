"use client"
import { SchoolFeesChart, UsersChart } from '@/components/chatFrames'
import Link from 'next/link'

import React, { useEffect, useState } from 'react'

const AdminHome = () => {

  const [timeofDay, setTimeOfDay] = useState('')


  useEffect(() =>{
    const updateGreeting = () =>{
      const currentHour = new Date().getHours()
      console.log(currentHour)

      if(currentHour >=0 && currentHour < 12){
        setTimeOfDay('Bonjour')
      }else if(currentHour >= 12 && currentHour < 16){
        setTimeOfDay('Bonjour')
      }else if(currentHour >= 16 && currentHour < 24){
        setTimeOfDay('Bonsoir')
      }
    }

    updateGreeting()

    const interval = setInterval(updateGreeting, 60 * 60 * 1000)

    return () => clearInterval(interval)
  }, [])


  return (
    <div>
      <p className='stylish-text md-text pb-4'>{timeofDay} 👋</p>

      <section>
        <div className="row g-4">
          <div className="col-8">
            <div className="row g-4">
              <div className="col-4">
                <div className="site-boxes border-radius-10px p-3">
                  <div className=''>
                    <div className="d-flex align-center mb-3">
                      <div className='primary-bg site-small-icon border-radius-5px me-2'>
                        <i className="ri-group-line  white-text"></i>
                      </div>
                      <p className='light-text'>Total Students</p>
                    </div>

                    <p className="lg-text">25</p>
                    <p className="light-text xsm-text">Students are present now</p>
                  </div>
                </div>
              </div>

              <div className="col-4">
                <div className="site-boxes border-radius-10px p-3">
                  <div className=''>
                    <div className="d-flex align-center mb-3">
                      <div className='secondary-bg site-small-icon border-radius-5px me-2'>
                        <i className="ri-group-2-fill  white-text"></i>
                      </div>
                      <p className='light-text'>Total Teachers</p>
                    </div>

                    <p className="lg-text">43</p>
                    <p className="light-text xsm-text">Teachers are present now</p>
                  </div>
                </div>
              </div>

              <div className="col-4">
                <div className="site-boxes border-radius-10px p-3">
                  <div className=''>
                    <div className="d-flex align-center mb-3">
                      <div className='support-bg site-small-icon border-radius-5px me-2'>
                        <i className="ri-parent-line  white-text"></i>
                      </div>
                      <p className='light-text'>Total Parents</p>
                    </div>

                    <p className="lg-text">33</p>
                    <p className="light-text xsm-text">Parents are present now</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="mt-4">
              <div className="site-boxes border-radius-10px p-3">
                <div>
                  <h6>User Accounts</h6>
                  <p className="sm-text light-text">All users that have been registered</p>
                </div>
                <div className="d-flex light-text">
                  <div className='pe-5'>
                    <h3 className="pb-1 ">2</h3>
                    <p className="sm-text">Students</p>
                  </div>

                  <div className='pe-5'>
                    <h3 className="pb-1 ">2</h3>
                    <p className="sm-text">Teachers</p>
                  </div>

                  <div className='pe-5'>
                    <h3 className="pb-1">2</h3>
                    <p className="sm-text">Parents</p>
                  </div>

                  <div className='pe-5'>
                    <h3 className="pb-1">2</h3>
                    <p className="sm-text">Staffs</p>
                  </div>
                </div>

                <div className="py-3">
                  <UsersChart
                    studentCount={1}
                    teacherCount={5}
                    parentCount={9}
                    staffCount={3}
                  />
                </div>
              </div>
            </div>
          </div>

          <div className="col-4">
            <div className="site-boxes border-radius-10px p-3">
              <div>
                <h6>Recent Notifications</h6>
              </div>

              <div>
                <div>
                  <p className="pb-3 sm-text d-flex justify-content-end support-text">1st May, 2025</p>
                  <p className='light-text sm-text'>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Hic, libero!</p>
                </div>
                <hr />

                <div>
                  <p className="pb-3 sm-text d-flex justify-content-end support-text">1st May, 2025</p>
                  <p className='light-text sm-text'>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Hic, libero!</p>
                </div>
                <hr />

                <div>
                  <p className="pb-3 sm-text d-flex justify-content-end support-text">1st May, 2025</p>
                  <p className='light-text sm-text'>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Hic, libero!</p>
                </div>
                <hr />

                <div>
                  <p className="pb-3 sm-text d-flex justify-content-end support-text">1st May, 2025</p>
                  <p className='light-text sm-text'>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Hic, libero!</p>
                </div>
                <hr />

                
              </div>

              <div>
                <Link href='' className='site-btn width-100 Link'>View All</Link>
              </div>
              
            </div>
          </div>

          <div className="col-4">
            <div className="site-boxes border-radius-10px p-3">
              <div>
                <h6>School Chart</h6>
              </div>
              {/* <div className="d-flex light-text">
                <div className='pe-5'>
                  <h3 className="pb-1 ">2</h3>
                  <p className="sm-text">All</p>
                </div>

                <div className='pe-5'>
                  <h3 className="pb-1 ">2</h3>
                  <p className="sm-text">Pending</p>
                </div>

                <div className='pe-5'>
                  <h3 className="pb-1">2</h3>
                  <p className="sm-text">Confirmed</p>
                </div>

                <div className='pe-5'>
                  <h3 className="pb-1">2</h3>
                  <p className="sm-text">Declined</p>
                </div>
              </div> */}

              <div className="py-3">
                <SchoolFeesChart 
                  allCount={2}
                  pendingCount={5}
                  successfulCount={5}
                  declinedCount={4}
                />
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  )
}

export default AdminHome