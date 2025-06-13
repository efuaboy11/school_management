"use client"
import { faEllipsis, faX } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { useContext, useEffect, useRef, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Pagination, Stack } from '@mui/material';
import AllDataContext from '@/context/AllData'
import AuthContext from '@/context/AuthContext'
import { debounce } from "lodash";
import { useForm } from 'react-hook-form'

const TermPage = () => {



  const {
    termCount,
    termData,
    setTermData,
    termLoader,

    termSearch,
    setTermSearch,
    TermFunction, 
    FilterTerm,

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
      if(!termSearch){
        TermFunction()
      }else if(termSearch){
        const debouncedSearch = debounce(() => {
          FilterTerm();
        }, 300);
        debouncedSearch();

        return () => {
          debouncedSearch.cancel();
        };
        
      }
     
    }, [termSearch])



  useEffect(() =>{
    TermFunction()

  }, [])
  
  
  

  const itemsPerPage = 10;
  const [page, setPage] = useState(1);

  const [selectedIDs, setSelectedIDs] = useState<number[]>([]);
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [animateModal, setAnimateModal] = useState(false);

  const [status, setStatus] = useState('')
  const [statusLoader, setStatusLoader] = useState(false)
  const statusModal = useRef<any>(null)
  const [statusOverlay, setStatusOverlay] = useState(false)
  const [selectedDataId, setSelectedDataId] = useState(null);
  const [termValue, setTermValue] = useState('')

  const handleCloseDeleteModal = () => {
    setShowDeleteModal(false);
  };
  const handleShowDeleteModal = () => {
    setShowDeleteModal(true);
  };
  const handleSelectAll = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (event.target.checked) {
      const allIDs = termData.map((data) => data.id);
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


  const showStatusModal = (id:any, term:string) =>{
    setTermValue(term)
    if(statusModal.current){
      statusModal.current.style.transform = `translateY(${0}px)`
      statusModal.current.style.transition = `all ${1.5}s ease`
    }
    setStatusOverlay(true)
    setSelectedDataId(id)
  }

  const hideStatusModal = () => {
    if(statusModal.current){
      statusModal.current.style.transform = `translateY(${-650}%)`
      statusModal.current.style.transition = `all ${5}s ease`
    }
    setSelectedDataId(null)

  }

  
  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    setPage(value);
  };

  const {
    register,
    handleSubmit,
    formState: { errors, isValid },
  } = useForm();

  // const termData = [...Array(100).keys()];
  const startIndex = (page - 1) * itemsPerPage;
  const currentItems = termData.slice(startIndex, startIndex + itemsPerPage);

  const onSubmit = (e:any) =>{
    UpdateTerm(e)
      
  }


    const UpdateTerm = async(e:any) =>{
    setStatusLoader(true)
    setDisableButton(true)

    try{
      const response = await fetch(`http://127.0.0.1:8000/api/term/${selectedDataId}/`, {
        method: 'PATCH',
        body: JSON.stringify({
          name: termValue,
        }),
        headers:{
          Authorization: `Bearer ${authTokens?.access}`,
          "Content-Type": "application/json"
        }
      })

      if(response.ok){
        showAlert()
        setMessage("Status updated sucessfully")
        setDisableButton(false)
        setStatus('')
        setIsSuccess(true)
        setStatusLoader(false)
        hideStatusModal()
        TermFunction()
      }else{
        const errorData = await response.json()
        const errorMessages = Object.values(errorData)
        .flat()
        .join(', ');
        setMessage(errorMessages)
        setDisableButton(false)
        setStatusLoader(false)
        setIsSuccess(false)
        showAlert()

      }
    }catch(error){
      console.log(error)
      showAlert()
      setMessage('An unexpected error occurred.');
      setDisableButton(false)
      setIsSuccess(false)
      setStatusLoader(false)

    } 
  }

  const deleteFunction = async () =>{
    setDisableButton(true)
    setLoader(true)

    try{
      let response = await fetch('http://127.0.0.1:8000/api/delete-multiple-term/', {
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
        setTermData(termData.filter(dat => dat.id !== selectedIDs))
        setShowDeleteModal(false)
        setSelectedIDs([])
        setMessage("Data entry deleted successfully")
        TermFunction()
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

  useEffect(() => {
    let timer: any;
    if (selectedDataId == null) {
      timer = setTimeout(() => {
        setStatusOverlay(false);
      }, 1000);
    }

  
    return () => clearTimeout(timer);
  }, [selectedDataId]);



  return (
    <div className='mb-5 pb-5'>
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

            <div className={`${statusOverlay ? 'overlay-background pt-5 ': ''}`}>
              <div className="dashboard-update-status-container" ref={statusModal}>
                <div className="row justify-content-center">
                  <div className="col-xl-3 col-lg-5 col-md-6 col-sm-9 col-11">
                    <div className="site-boxes px-4 py-3 border-radius-10px">
                      <div className="d-flex justify-content-end">
                        <FontAwesomeIcon className='sm-text cursor-pointer' icon={faX} onClick={hideStatusModal}/>
                      </div>
                      <form onSubmit={handleSubmit(onSubmit)}>
                        <div>
                          <label htmlFor="" className="p-2 d-block">Term Name</label>
                          <input type='text' placeholder='Term name'  className={`${errors.status ? 'error-input' : ''} d-block site-search-input`} {...register('status', {required: true})}   value={termValue} onChange={(e) => setTermValue(e.target.value)}/>
                          {errors.status && <span style={{color: 'red'}}>This Feild is required</span>} 
                        </div>
      
                        <div className="d-flex justify-content-end">
                          <div className='pt-3'>
                            <button disabled={disableButton} type="submit" className={`Button site-btn px-3`}>
                              <span className={`${statusLoader ? 'site-submit-spinner': ''}`}></span>
                              <span className={`${statusLoader ? 'site-submit-btn-visiblity': ''}`}><i className="ri-upload-line me-2"></i>Update</span>
                            </button>
                          </div>
                        </div>
      
      
                      </form>
      
                    </div>
                  </div>
                </div>
      
              </div>
            </div>
      <div className="container-xl pt-4">
        <div className="d-md-flex justify-content-between">
          <div>
            <p className="md-text">Term</p>
            <p className="light-text pb-3">Total of {termCount} term avaliable</p>
         </div>

          <div className='d-flex mb-4'>
            <Link href='/admin/term/add' className="site-btn px-3 Link"><i className="ri-send-plane-fill pe-2"></i> Add Term</Link>
          </div>
        </div>

        <div className="d-flex justify-content-end">

          <div>
            <div className="d-flex align-items-center">
              <input type="text" className="site-search-input" placeholder="Search" value={termSearch} onChange={(e) => setTermSearch(e.target.value)}/>
              <button className="site-btn px-3 ms-2"><i className="ri-search-line"></i></button>
            </div>
          </div>
        </div>

        <div>
          {termLoader ? (
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
            <div className='mt-5'>
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
                              checked={selectedIDs.length === termData.length && termData.length > 0}
                              onChange={handleSelectAll}
                            />
                              <span className="checkmark"></span>
                            </label>
                          </th>
                          <th>Term Name</th>
                          <th></th>
                        </tr>
                      </thead>

                      <tbody>
                        {currentItems.length > 0 ? (
                          currentItems.map((data) => (
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
                                {formatName(data.name)}
                              </td>
                              <td>
                                <div className='d-flex justify-content-end align-center'>
                                  <div onClick={() => showStatusModal(data.id, data.name)} className='ms-3 cursor-pointer'>
                                    <i className="ri-edit-line"></i>
                                  </div>
                      
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

                  {termData.length > 10 && (
                      <div className="col-12 mb-4 mt-3">
                        <Stack spacing={2} alignItems="end">
                          <Pagination
                            count={Math.ceil(termData.length / itemsPerPage)}
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
                  <div className='site-boxes text-center pb-5 d-flex justify-content-center align-items-center  mt-5 pt-5'>
                    <div>
                      <Image src="/img/icon/thinking.png" alt="empty" width={100} height={100} />
                      <p className='light-text md-text'>No details available</p>
                      <p className="light-text">There is no  details right now. Check again later</p>
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

export default TermPage