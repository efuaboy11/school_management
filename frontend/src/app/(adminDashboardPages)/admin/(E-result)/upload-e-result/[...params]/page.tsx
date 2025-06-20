"use client"
import AllDataContext from '@/context/AllData'
import AuthContext from '@/context/AuthContext'
import ThemeContext from '@/context/ThemeContext'
import Link from 'next/link'
import React, { use, useContext, useEffect, useState } from 'react'
import { useDropzone } from 'react-dropzone';
import { useForm } from 'react-hook-form'
import Select from 'react-select';
import Image from 'next/image'
import { Pagination, Stack } from '@mui/material';
import { DownloadLink } from '@/components/downloadLink'
import { debounce } from "lodash";

const UploadEResult2Page = ({ params }: { params: Promise<any> }) => {

  const param = use(params);
  const [classID, termID, sessionID] = param.params || [];


  const [studentValue, setStudentValue] = useState('')
  const [file, setFile] = useState<File | null>(null)

  const [resultCount, setResultCount] = useState(0)
  const [resultData, setResultData] = useState<any>([])
  const [resultLoader, setResultLoader] = useState(true)

  const [termDetails, setTermDetails] = useState<any>(null)
  const [studentClassDetails, setStudentClassDetails] = useState<any>(null)
  const [sessionDetails, setSessionDetails] = useState<any>(null)

  const [hasMounted, setHasMounted] = useState(false);
  
  useEffect(() => {
    setHasMounted(true);
  }, []);

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
  
    
  
  
  } = useContext(AuthContext)!


  const {
    studentData,
    StudentFunction,
  } = useContext(AllDataContext)!;

  const { theme, toggleTheme } = useContext(ThemeContext)!;
 


  const {
    register,
    handleSubmit,
    formState: {errors, isValid},
  } = useForm<any>();





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
      const allIDs = resultData.map((data:any) => data.id);
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

  // const resultData = [...Array(100).keys()];
  const startIndex = (page - 1) * itemsPerPage;
  const currentItems = resultData.slice(startIndex, startIndex + itemsPerPage);




  const handleFile = (event:any) => {
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      setFile(file); 
    } else {
      setFile(null); 
    }
  };

  const [studentQuery, setStudentQuery] = useState('')
  const [filterOptions, setOptions] = useState(false)

  const toggleFilterOptions = () =>{
    setOptions(!filterOptions)
  }



  const StudentsOptions = studentData.map((data: any) => ({
    value: data.id,
    label: `${data.first_name} ${data.last_name}`
  }));

  


  const customStyles = {
    control: (provided: any, state: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#0d0d0d' : '#fff',
      borderColor: state.isFocused ? '#783ebc' : theme === 'light' ? '#ccc' : '#333',
      boxShadow: state.isFocused ? '0 0 0 4px rgba(120, 62, 188, 0.2)' : 'none',
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    menu: (provided: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#0d0d0d' : '#fff',
      border: '1px solid #ccc',
      zIndex: 999,
    }),
  
    option: (provided: any, state: any) => {
      const isDark = theme === 'dark';
  
      const backgroundColor = state.isSelected
        ? '#783ebc'
        : state.isFocused
        ? isDark
          ? '#1a1a1a' // hover in dark
          : '#f0f0f0' // hover in light
        : isDark
        ? '#0d0d0d'
        : '#fff';
  
      const color = state.isSelected
        ? '#fff'
        : state.isFocused
        ? isDark
          ? '#fff'
          : '#000'
        : isDark
        ? '#fff'
        : '#000';
  
      return {
        ...provided,
        backgroundColor,
        color,
        cursor: 'pointer',
      };
    },
  
    singleValue: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    placeholder: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#aaa' : '#666',
    }),
  
    input: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    dropdownIndicator: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    indicatorSeparator: (provided: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#444' : '#ccc',
    }),
  };




  const onSubmit = (data: FormData, e:any) => {
    if(studentValue && file != null){
      UploadResult(e)
    }else{
      showAlert()
      setMessage('A field is empty')
      setIsSuccess(false)
    }
    
  }


  const UploadResult = async(e:any) =>{
    e.preventDefault()
    setLoader(true)
    setDisableButton(true)

    const formData = new FormData()
    formData.append('student', studentValue)
    formData.append('student_class', classID)
    formData.append('term', termID)
    formData.append('session', sessionID)
    if(file){
      formData.append('result', file)  
    }



    try{
      const response = await fetch(`http://127.0.0.1:8000/api/e-result/`, {
        method: 'POST',
        body: formData,
        headers:{
          Authorization: `Bearer ${authTokens?.access}`
        }
      })


      if(response.ok){
        showAlert()
        setMessage('Result uploaded successfully')
        setIsSuccess(true)
        setLoader(false)
        setDisableButton(false)
        setStudentValue('')
        ResultFunction()
        setFile(null)




      }else{
        const errorData = await response.json()
        const errorMessages = Object.values(errorData)
        .flat()
        .join(', ');
        setMessage(errorMessages)
        setDisableButton(false)
        setIsSuccess(false)
        setLoader(false)
        showAlert()
      }

      
    }catch(error){
      console.log(error)
      showAlert()
      setMessage('An unexpected error occurred.');
      setDisableButton(false)
      setIsSuccess(false)
      setLoader(false)

    }  
  }



  const ResultFunction = async() =>{
    let response = await fetch(`http://127.0.0.1:8000/api/e-result/?student=${studentQuery}&student_class=${classID}&term=${termID}&session=${sessionID}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setResultCount(data.length)
      }
      
      
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      setResultData(sortedData)
      setResultLoader(false)


    }else{
      setResultLoader(false)
      setResultData([])
    }



  }



  const deleteFunction = async () =>{
    setDisableButton(true)
    setLoader(true)

    try{
      let response = await fetch('http://127.0.0.1:8000/api/delete-multiple-e-result/', {
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
        setShowDeleteModal(false)
        setSelectedIDs([])
        setMessage("Data entry deleted successfully")
        ResultFunction()
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

  const IndividualTerm = async () =>{
    try{
      let response = await fetch(`http://127.0.0.1:8000/api/term/${termID}/`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authTokens?.access}`,
        },

      })
      const data = await response.json()

      if(response.ok){
        setTermDetails(data)
        console.log('data', data)      
      }
    }catch{
      console.log('error')
    }

  }

  const IndividualClass = async () =>{
    try{
      let response = await fetch(`http://127.0.0.1:8000/api/student-class/${classID}/`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authTokens?.access}`,
        },

      })
      const data = await response.json()

      if(response.ok){
        setStudentClassDetails(data)
        console.log('data', data)      
      }
    }catch{
      console.log('error')
    }

  }

    const IndividualSessionFunction = async () =>{
    try{
      let response = await fetch(`http://127.0.0.1:8000/api/session/${sessionID}/`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authTokens?.access}`,
        },

      })
      const data = await response.json()

      if(response.ok){
        setSessionDetails(data)
  
      }
    }catch{
      console.log('error')

    }

  }

  useEffect(() =>{
    StudentFunction()
    IndividualSessionFunction()
    IndividualClass()
    IndividualTerm()
    setLoader(false)
    ResultFunction()

  }, [])

  useEffect(() =>{
    ResultFunction()
  }, [studentQuery])

 
  useEffect(() => {
    if (showDeleteModal) {
      setAnimateModal(true)
    } else {
      setAnimateModal(false);
    }
  }, [showDeleteModal]);
  


  




  return (
    <div>
      <div className="container-lg my-5 pt-2">

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
        <div className="row justify-content-center">
          <div className="col-sm-8">
            <div className="site-boxes border-radius-10px">
              <div className="border-bottom1 text-center p-3">
                <p>Upload Result <i className="bi bi-dash-lg"></i> 2</p>
              </div>

              <div className="p-3">
                {hasMounted && (
                  <form onSubmit={handleSubmit(onSubmit)}>
                    <div className="row g-4">
                      <div className="col-md-6">
                        <label htmlFor="lastName" className="form-label">Select Student<span className="text-danger">*</span> </label>
                        <Select
                          options={StudentsOptions}
                          value={StudentsOptions.find((opt: { value: string; label: string }) => opt.value === studentValue)}
                          onChange={(selectedOption: { value: string; label: string } | null) => setStudentValue(selectedOption?.value || '')}
                          placeholder="Select"
                          classNamePrefix="site-select"
                          styles={customStyles}  // ✅ Add this
                          isSearchable
                          isClearable
                        />
                      </div>

                    

                      <div className="col-lg-3 col-md-6">
                        <label htmlFor="cv" className="form-label">Result</label>
                        
                        <input
                          type="file"
                          id="cv"
                          {...register('passport')}
                          onChange={handleFile}
                          className="d-none"
                        />

                        <label htmlFor="cv" className="dropzone-box">
                          {
                            file ? (
                              <p>{file.name}</p>
                            ) : (
                              <p> click to select file</p>
                            )
                          }
                        </label>
                      </div>

                      <div className="col-12">
                        <p className="light-text sm-text italic-text">Note: This result you are about to upload will go to Result for <br /> {studentClassDetails &&  formatName(studentClassDetails?.name)} <i className="bi bi-dash-lg"></i>  {termDetails && formatName(termDetails?.name)} <i className="bi bi-dash-lg"></i>  {sessionDetails && formatName(sessionDetails?.name)}  database</p>
                      </div>
                  


                      <div className="col-12 mt-4">
                        <button type='submit' className='site-btn px-4'>
                          <span className={`${loader ? 'site-submit-spinner': ''}`}></span>
                          <span className={`${loader ? 'site-submit-btn-visiblity': ''}`}><i className="ri-send-plane-fill pe-2"></i> Sumbit</span>
                        </button>
                    
                      </div>
                    </div>

                  </form>
              )}
  
              </div>
            </div>
          </div>
        </div>

        <div className='mt-5'>
          

          <div className='pt-5'>
            <div className='row'>
              <div className="col-2 d-flex align-items-center">
                <p className='pe-2 light-text'>Filter</p>
                <label className="site-switch">
                  <input type="checkbox" onChange={toggleFilterOptions}/>
                  <span className="site-switch-slider"></span>
                </label>
              </div>

              <div className="col-10">
                <p className='text-center light-text pb-3'>Scheme of work for {studentClassDetails &&  formatName(studentClassDetails?.name)} <i className="bi bi-dash-lg"></i>  {termDetails && formatName(termDetails?.name)}</p>
              </div>
              

            </div>
            {filterOptions && (
              <div className="d-sm-flex justify-content-start pt-3">
                <div className="d-sm-flex">
                  <div className="me-3 mb-3">
                    <label htmlFor="lastName" className="form-label">Select Student</label>
                    <Select
                      options={StudentsOptions}
                      value={StudentsOptions.find((opt: { value: string; label: string }) => opt.value === studentQuery)}
                      onChange={(selectedOption: { value: string; label: string } | null) => setStudentQuery(selectedOption?.value || '')}
                      placeholder="Select Student"
                      classNamePrefix="site-select"
                      styles={customStyles}  // ✅ Add this
                      isSearchable
                      isClearable
                    />
                  </div>

        
                </div>
              </div>
            )}

          </div>
          {resultLoader ? (
            <div className="site-boxes border-radius-10px p-5 d-flex justify-content-center">
              <div className="site-content-loader"></div>
            </div>
          ) : (
            <div>
              {currentItems.length > 0 ? (
                <div>
                  {selectedIDs.length > 0 ? (
                          <div className='pb-2'>
                            <button onClick={handleShowDeleteModal}  className='site-delete-btn px-3'><i className="ri-delete-bin-line me-2"></i>Delete</button>
                          </div>
                    ): (
                      <div></div>
                    )
                  }
                  <div className='site-boxes  site-border border-radius-5px dahboard-table non-wrap-text scroll-bar'>
                    <table className='overflow-auto light-text'>
                      <thead className='sm-text'>
                        <tr>
                          <th className='py-2'>
                            <label className="custom-checkbox cursor-pointer">
                            <input
                              type="checkbox"
                              checked={selectedIDs.length === resultData.length && resultData.length > 0}
                              onChange={handleSelectAll}
                            />
                              <span className="checkmark"></span>
                            </label>
                          </th>
                          <th>Student</th>
                          <th>Result</th>
                          <th></th>
                        </tr>
                      </thead>

                      <tbody>
                        {currentItems.length > 0 ? (
                          currentItems.map((data:any) => (
                            <tr key={data.id}>
                              <td className='py-3'>
                                  <label className="custom-checkbox cursor-pointer">
                                    <input
                                      type="checkbox"
                                      checked={selectedIDs.includes(data.id)}
                                      onChange={() => handleCheckboxChange(data.id)}
                                    />
                                    <span className="checkmark"></span>
                                  </label>
                              </td>
                              <td className='py-3'>
                                {formatName(data.student_name.first_name)} {formatName(data.student_name.last_name)}
                              </td>
                              <td>
                                <DownloadLink
                                  url={data.result}
                                  fileName={`${data.student_name.first_name}__${data.student_name.last_name}__result.pdf`}
                                />
                              </td>
                              <td>
                                <div className="d-flex justify-content-end">
                                  <Link href={`/admin/individual-e-result/${data.id}`} className="Link site-border box-50px d-flex  align-center justify-content-center border-radius-5px cursor-pointer">
                                    <i className="ri-eye-line"></i>
                                  </Link>
                                </div>
                              </td>
                            </tr>

                          ))

                        ) : (
                          <tr>
                            <td className="py-4">No details available</td>
                          </tr>
                        )}


                      </tbody>

                    </table>

                  </div>

                  {resultData.length > 10 && (
                      <div className="col-12 mb-4 mt-3">
                        <Stack spacing={2} alignItems="end">
                          <Pagination
                            count={Math.ceil(resultData.length / itemsPerPage)}
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

              
              ): (
                <div className="col-12 ">
                  <div className='site-boxes text-center pb-5 d-flex justify-content-center align-items-center   pt-5'>
                    <div>
                      <Image src="/img/icon/thinking.png" alt="empty" width={100} height={100} />
                      <p className='light-text md-text'>No Result Available</p>
                      <p className="light-text">There is no result available right now. Upload above</p>
                    </div>

                  </div>

                </div>
              )}
            </div>
          )}


        </div>


      </div>
    </div>
  )
}

export default UploadEResult2Page