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

const AllParents = () => {

  const {
    parentCount,
    parentData,
    setParentData,
    parentLoader,

    parentSearch,
    setParentSearch,
    ParentFunction, 
    FilterParent,
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
      if(!parentSearch){
        ParentFunction()
      }else if(parentSearch){
        const debouncedSearch = debounce(() => {
          FilterParent();
        }, 300);
        debouncedSearch();

        return () => {
          debouncedSearch.cancel();
        };
        
      }
     
    }, [parentSearch])

  console.log(parentSearch)
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
      const allIDs = parentData.map((data) => data.id);
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

  // const parentData = [...Array(100).keys()];
  const startIndex = (page - 1) * itemsPerPage;
  const currentItems = parentData.slice(startIndex, startIndex + itemsPerPage);


  const deleteFunction = async () =>{
    setDisableButton(true)
    setLoader(true)

    try{
      let response = await fetch('http://127.0.0.1:8000/api/delete-multiple-parents/', {
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
        setParentData(parentData.filter(dat => dat.id !== selectedIDs))
        setShowDeleteModal(false)
        setSelectedIDs([])
        setMessage("Data entry deleted successfully")
        ParentFunction()
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
      <div className="container-xl pt-4">
        <div className="d-flex justify-content-between">
          <div>
            <p className="md-text">Parents</p>
            <p className="light-text pb-3">Total of {parentCount} parents avaliable</p>
          </div>

          <div className='d-none d-sm-block'>
            <Link href='/admin/add-parent' className="site-btn px-3 Link"><i className="ri-user-add-line pe-2"></i> Add  Parent</Link>
          </div>
        </div>

        <div className="d-flex justify-content-end">

          <div>
            <div className="d-flex align-items-center">
              <input type="text" className="f site-search-input" placeholder="Search" value={parentSearch} onChange={(e) => setParentSearch(e.target.value)}/>
              <button className="site-btn px-3 ms-2"><i className="ri-search-line"></i></button>
            </div>
          </div>
        </div>

        <div>
          {parentLoader ? (
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
                  <div className=' light-text site-border border-radius-5px dahboard-table non-wrap-text scroll-bar'>
                    <table className='overflow-auto'>
                      <thead className='sm-text'>
                        <tr>
                          <th className='py-2'>
                            <label className="custom-checkbox cursor-pointer">
                            <input
                              type="checkbox"
                              checked={selectedIDs.length === parentData.length && parentData.length > 0}
                              onChange={handleSelectAll}
                            />
                              <span className="checkmark"></span>
                            </label>
                          </th>
                          <th>Name</th>
                          <th>Phone Number</th>
                          <th> Email</th>
                          <th>address</th>
                          <th>children name</th>
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
                                <div className="d-flex align-center">
                                  <Image className='border-radius-50' src={data.image} alt="Logo" width={50} height={50} />
                                  <p className='ms-3'>{formatName(data.name)}</p>
                                </div>
                              </td>
                              <td>{data.phone_number}</td>
                              <td>{data.email}</td>
                              <td>{formatName(truncateText(data.address, 1))}</td>
                              <td>{formatName(truncateText(data.children_name, 1))}</td>
                              <td>
                                <Link href={`/admin/all-parents/${data.id}`} className="Link site-border box-50px d-flex  align-center justify-content-center border-radius-5px cursor-pointer">
                                  <i className="ri-eye-line"></i>
                                </Link>
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
                    {parentData.length > 10 && (
                      <div className="col-12 mb-4">
                        <Stack spacing={2} alignItems="center">
                          <Pagination
                            count={Math.ceil(parentData.length / itemsPerPage)}
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
                </div>

              
              ): (
                <div className="col-12 ">
                  <div className='site-boxes text-center pb-5 d-flex justify-content-center align-items-center  mt-5 pt-5'>
                    <div>
                      <Image src="/img/icon/thinking.png" alt="empty" width={100} height={100} />
                      <p className='light-text md-text'>No parent available</p>
                      <p className="light-text">There is no parent current right now. Check again later</p>
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

export default AllParents