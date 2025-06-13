"use client"
import { faEllipsis } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { useContext, useEffect, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Pagination, Stack } from '@mui/material';
import AllDataContext from '@/context/AllData'
import AuthContext from '@/context/AuthContext'
import { debounce } from "lodash";
const AllStudents = () => {

  const {
    studentCount,
    studentData,
    setStudentData,
    studentLoader,

    studentSearch,
    setStudentSearch,
    StudentFunction, 
    FilterStudent,
  } = useContext(AllDataContext)!;

    const {
      truncateText,
      authTokens,
      formateDateTime,
      formatDate,
      formatName,
      formatCurrency,
      showSidebar,
      loader,
      setLoader,
      disableButton,
      setDisableButton,

      setMessage,
      showAlert,
      setIsSuccess,
  
    } = useContext(AuthContext)!;

    useEffect(() =>{
      if(!studentSearch){
        StudentFunction()
      }else if(studentSearch){
        const debouncedSearch = debounce(() => {
          FilterStudent();
        }, 300);
        debouncedSearch();

        return () => {
          debouncedSearch.cancel();
        };
        
      }
     
    }, [studentSearch])


  const itemsPerPage = 10;
  const [page, setPage] = useState(1);

  const [selectedIDs, setSelectedIDs] = useState<number[]>([]);
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [animateModal, setAnimateModal] = useState(false);

  const handleCloseDeleteModal = () => {
    setShowDeleteModal(false);
  };
  const handleShowDeleteModal = () => {
    setShowDeleteModal(true);
  };
  const handleSelectAll = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (event.target.checked) {
      const allIDs = studentData.map((data) => data.id);
      setSelectedIDs(allIDs);
    } else {
      setSelectedIDs([]);
    }
  };
  const handleCheckboxChange = (id: number) => {
    if (selectedIDs.includes(id)) {
      setSelectedIDs(selectedIDs.filter((selectedId) => selectedId !== id));
    } else {
      setSelectedIDs([...selectedIDs, id]);
    }
  }

  
  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    setPage(value);
  };

  // const studentData = [...Array(100).keys()];
  const startIndex = (page - 1) * itemsPerPage;
  const currentItems = studentData.slice(startIndex, startIndex + itemsPerPage);


  const deleteFunction = async () =>{
    setDisableButton(true)
    setLoader(true)

    try{
      let response = await fetch('http://127.0.0.1:8000/api/delete-multiple-students/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authTokens?.access}`,
        },
        body: JSON.stringify({
          ids: selectedIDs,
        }),

      })

      if(response.ok){
        setLoader(false)
        setDisableButton(false)
        setStudentData(studentData.filter(dat => dat.id !== selectedIDs))
        setShowDeleteModal(false)
        setSelectedIDs([])
        setMessage("Data entry deleted successfully")
        StudentFunction()
        showAlert()
        setIsSuccess(true)
        
          
      }else {
        const errorData = await response.json()
        const errorMessages = Object.values(errorData)
        .flat()
        .join(', ');

        setLoader(false)
        setDisableButton(false)
        setMessage(errorMessages)
        showAlert()
        setIsSuccess(false)

      }
    }catch(error){
      setLoader(false)
      setDisableButton(false)
      setMessage("An error occurred. Please try again.")
      showAlert()
      setIsSuccess(false)
    }
  }

 

  useEffect(() => {
    if (showDeleteModal) {
      setAnimateModal(true)
    } else {
      setAnimateModal(false);
    }
  }, [showDeleteModal]);



  return (
    <div>
      {showDeleteModal && (
        <section className={` ${showDeleteModal ? 'overlay-background' : ''}`}>
          <div className='container-lg'>
              
            <div className=" row justify-content-center align-center2 height-90vh">

                <div className="col-xl-5 col-lg-6 col-md-8 col-sm-10 col-12">
                  <div className="site-modal-conatiner">
                    <div className={`site-modal-content scroll-bar  ${animateModal ? 'show-modal' : 'hide-modal'}`}>
                      <div className="d-flex justify-content-center text-center">
                        <div>
                          <Image src="/img/icon/warning.png" alt="empty" width={100} height={100} />
                          <p className='md-text mt-3'>Are you sure?</p>
                          <p className="light-text">This action cannot be undone. {selectedIDs.length} selected {selectedIDs.length === 1 ? 'data entry' : 'data entries'} will be deleted.</p>
                          <div className='pt-4'>
                            <button className="site-delete-btn px-3 me-2 width-100 mb-4" onClick={deleteFunction} disabled={disableButton}>
                              <span className={`${loader ? 'site-submit-spinner': ''}`}></span>
                              <span className={`${loader ? 'site-submit-btn-visiblity': ''}`}><i className="ri-delete-bin-line pe-2"></i> Delete</span>
                            </button>
                            <button onClick={handleCloseDeleteModal} className="site-btn site-cancel-btn px-3 width-100"><i className="ri-close-circle-line pe-2"></i>Cancel</button>
                          </div>
                        </div>
                      </div>
                    
                    </div>
                  </div>
                </div>
            

            </div>

          </div>
        </section>
      )}
      <div className="container-xl">
        <div className="d-md-flex justify-content-between">
          <div>
            <p className="md-text">Students</p>
            <p className="light-text pb-3">Total of {studentCount} student avaliable</p>
          </div>

          <div className='d-flex mb-4'>
            <Link href='/admin/add-student' className="site-btn px-3 Link"><i className="ri-send-plane-fill pe-2"></i> Add student</Link>
          </div>
        </div>

        <div className="d-flex justify-content-end">

          <div>
            <div className="d-flex align-items-center">
              <input type="text" className="f site-search-input" placeholder="Search" value={studentSearch} onChange={(e) => setStudentSearch(e.target.value)}/>
              <button className="site-btn px-3 ms-2"><i className="ri-search-line"></i></button>
            </div>
          </div>
        </div>

        <div>
          {studentLoader ? (
            <div>
              <div className="mt-5 pt-5">
                <div className="d-flex justify-content-center align-items-center">
                  <div className="book-loader">
                    <div className="book red"></div>
                    <div className="book blue"></div>
                    <div className="book green"></div>
                  </div>
                </div>
              </div>
            </div>
          ) : (
            <div >
              {currentItems.length > 0 ? (
                <div className="row g-4 mt-4 mb-5">
                  <div className="col-12">
                    <div className="d-flex justify-content-between align-items-center">
                      {selectedIDs.length > 0 ? (
                        <div>
                          <button onClick={handleShowDeleteModal}  className='site-delete-btn px-3'><i className="ri-delete-bin-line me-2"></i>Delete</button>
                        </div>
                      ): (
                        <div></div>
                      )}

                      <label className="custom-checkbox cursor-pointer me-3">
                        <input
                          type="checkbox"
                          checked={selectedIDs.length === studentData.length && studentData.length > 0}
                          onChange={handleSelectAll}
                        />
                        <span className="checkmark"></span>
                      </label>
                    </div>
                  </div>
                  {studentData.map((data)=>(
                  <div className="col-lg-4 col-md-6" key={data.id}>
                    <div className="site-boxes border-radius-10px p-3">
                      <div className="d-flex justify-content-between">
                        <div className="d-flex">
                          <div className={`${data.account_status === 'active' ? 'site-successful-border': 'site-declined-border'}    border-radius-20px px-2 py-1`}>
                            <div className="d-flex align-center">
                              <div className={`${data.account_status === 'active' ? 'site-successful-dot' : 'site-declined-dot'}`}></div>
                              <p className='ms-2'>{formatName(data.account_status)}</p>
                            </div>
                          </div>
                        </div>

                        <div>
                          <div>
                          <label className="custom-checkbox cursor-pointer">
                            <input
                              type="checkbox"
                              checked={selectedIDs.includes(data.id)}
                              onChange={() => handleCheckboxChange(data.id)}
                            />
                            <span className="checkmark"></span>
                          </label>

                          </div>
                        </div>
                      </div>

                      <div className="d-flex mt-4 justify-content-center text-center">
                        <div>
                          <Image className='border-radius-50' src={data.passport} alt="Logo" width={70} height={70} />
                          <div className="pt-3">
                            <p>{formatName(data.first_name)} {formatName(data.last_name)}</p>
                            <p className='light-text'>Student</p>
                          </div>
                        </div>
                      </div>

                      <div className="wrap-text my-4 site-border border-radius-10px py-2 px-3 site-light-boxes ">
                        <div className="flex-wrap d-flex justify-content-between light-text mb-2">
                          <p>Student ID:</p>
                          <p>{data.userID}</p>
                        </div>

                        <div className="flex-wrap d-flex justify-content-between light-text mb-2">
                          <p>Class:</p>
                          <p>{formatName(data.student_class_name.name)}</p>
                        </div>

                        <div className="flex-wrap  d-flex justify-content-between light-text mb-2">
                          <p>Email:</p>
                          <p>{data.email}</p>
                        </div>

                        <div className="flex-wrap d-flex justify-content-between light-text mb-2">
                          <p>Phone number:</p>
                          <p>{data.phone_number}</p>
                        </div>

                        <div className="flex-wrap d-flex justify-content-between light-text mb-2">
                          <p>Admission number:</p>
                          <p>{data.admission_number}</p>
                        </div>
                      </div>

                      <div className="d-flex justify-content-between light-text">
                        <p>Joined at: {formatDate(data.date_joined)}</p>

                        <Link href={`/admin/all-student/${data.id}`} className='Link light-link'>View details</Link>
                      </div>

                    </div>
                  </div>
                  ))}
   
                </div>
               
              ): (
                <div className="col-12 ">
                  <div className='site-boxes text-center pb-5 d-flex justify-content-center align-items-center  mt-5 pt-5'>
                    <div>
                      <Image src="/img/icon/thinking.png" alt="empty" width={100} height={100} />
                      <p className='light-text md-text'>No student available</p>
                      <p className="light-text">There is no student current right now. Check again later</p>
                    </div>

                  </div>

                </div>
              )}

              {studentData.length > 10 && (
                <div className="col-12 mb-4">
                  <Stack spacing={2} alignItems="center">
                    <Pagination
                      count={Math.ceil(studentData.length / itemsPerPage)}
                      page={page}
                      onChange={handleChange}
                      sx={{
                        '& .MuiPaginationItem-root': {
                          color: '#737b7d', // color of all numbers
                        },
                        '& .MuiPaginationItem-root.Mui-selected': {
                          backgroundColor: '#783ebc', // Your custom color
                          color: '#fff',
                        },
                      }}
                    />
                  </Stack>
                </div>
              )}

            </div>
          )}


          
        </div>
      </div>
    </div>
  )
}

export default AllStudents