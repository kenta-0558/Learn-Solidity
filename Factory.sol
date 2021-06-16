// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;


interface TemplateInterface {
    event Initialized(bytes indexed abiBytes);
    function intialize(bytes memory abiBytes) external returns (bool);    
}