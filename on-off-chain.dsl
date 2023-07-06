!constant ORGANISATION_NAME "BlockchainLabUM"
!constant GROUP_NAME "SSI-Snap"

workspace "${ORGANISATION_NAME}" "${GROUP_NAME}" {

    model {
    
        user = person "Alice"
        
        group "Off-chain"{ 
        
            offChainWallet = softwareSystem "SSI wallet" "A high-level example of an SSI Wallet like Lissi" "offc" {
            
                userAuth1 = container "User authentication" "Ensures authentication and authorization for the wallet usage" "" "offc,common"
                
                cryptoInter1 = container "Cryptographic interface" "Generates keypairs, Produces signatures (on VCs), Verifies signatures (from VPs)" "" "offc,common" 
                
                VCInter1 = container "VC/VP interface" "Handles the management of VCs and VPs" "" "offc"
                
                DIDInter1 = container "DID interface" "Handles the management/usage of 1* DIDs" "" "offc"
                
                sensitiveMaterial1 = container "Sensitive cryptographic materials" "Key storage" "" "storage_offc,common"
                
                storage1 = container "Storage" "Stores all generated and recieved VCs and DID documents" "" "storage_offc"
             
                communicationInterface1 = container "Communication interface" "Ensures DIDComm or OIDC" "" "offc,common"
                
                gui1 = container "GUI" "Provides the grafical interface for the user" "" "offc,common"
                
                configInter1 = container "Configuration interface" "Configuring networks, accounts, RPCs" "" "offc,common"
            
                
                
            }
        }
        
        externalstorage = softwareSystem "External Storage" "An external cloud-like storage system" "storage2"
        
        group "On-chain"{
        
            onChainWallet = softwareSystem "On-chain wallet" "A high-level example of an Blockchain wallet like Metamask" "onc" {
                
                userAuth2 = container "User authentication" "Ensures authentication and authorization for the wallet usage" "" "onc,common"
                
                cryptoInter2 = container "Cryptographic interface" "Generates keypairs, Signs transactions or messages" "" "onc,common"
                
                sensitiveMaterial2 = container "Sensitive cryptographic materials" "Key storage" "" "storage_onc,common"
                
                communicationInterface2 = container "Communication interface" "Communicates with the blockchain network" "" "onc,common"
            
                web3 = container "Web3 interface" "Communicates with dApps over web3" "" "onc"
            
                configInter2 = container "Configuration interface" "Configuring networks, accounts, RPCs" "" "onc,common"
            
                gui2 = container "GUI" "Provides the grafical interface for the user" "" "onc,common"
                
                tokenInter = container "Token interface" "Manages various coins and tokens" "" "onc"
                
            }
        }
        
        blockchain = softwareSystem  "Blockchain System" "A high-level example of an Blockchain like Ethereum" "blockchain" 
        
        registry = softwareSystem  "Verifiable Data Registry" "A registry for DID documents and/or other registry related documents" "registry" 
        
        dapp = softwareSystem  "dApp" "Decentralized Web Application" "dapp" 
    
        issuer_verifier = softwareSystem  "Issuer/Verifier" "Various forms of Software system supported by SSI functionalities" "issuerverifier" {
            
            frontend = container "WebApp" "Classical Web Application" "app"
            backend = container "Backend" "A backend system supporting SSI functionalities" "other"
            offChainWalletIssuerVerifier = container "Off Chain Wallet Instance"
            
        }
        
         group "Centralized identity"{ 
        
            centralizedWallet = softwareSystem "Centralized/Federate identity wallet" "A high-level example of an Centralized Identity wallet like the EUDIW" "extra"
        }
        
    
        
        #OFF CHAIN
        user -> offChainWallet "Uses" "" "solid"
        user -> issuer_verifier "Uses services | Connects to" "HTML" "solid"
        user -> centralizedWallet "Uses" "" "solid"
        
        offChainWallet -> registry "Resolves, Fetches, Anchors <optional>" "API" "optional"
        offChainWallet -> blockchain "Resolves, Fetches, Anchors <optional>" "RPC" "optional"
        offChainWallet -> issuer_verifier "Communicates" "OIDC | DIDComm" "solid"
        
        communicationInterface1 -> issuer_verifier "Communicates" "OIDC | DIDComm" "solid"
        communicationInterface1 -> backend "OIDC" "" "solid"
        communicationInterface1 -> offChainWalletIssuerVerifier "DIDComm" "" "solid"
        
        cryptoInter1 -> sensitiveMaterial1 "Uses" "" "solid"
        communicationInterface1 -> VCInter1 "Uses" "" "solid"
        VCInter1 -> storage1 "Uses <optional>" "" "optional"
        DIDInter1 -> storage1 "Uses <optional>" "" "optional"
        communicationInterface1 -> DIDInter1 "Uses" "" "solid"
        DIDInter1 -> communicationInterface1 "Uses" "" "solid"
        
        VCInter1 -> cryptoInter1 "Uses" "" "solid"
        VCInter1 -> DIDInter1 "Uses" "" "solid"
        configInter1 -> DIDInter1 "Configures DID control" "" "solid" 
        DIDInter1 -> cryptoInter1 "Uses" "" "solid"
        configInter1 -> communicationInterface1 "Manages communication forms" "" "solid"
        communicationInterface1 -> blockchain "Resolves, Fetches, Anchors" "" "solid" 
        communicationInterface1 -> registry "Resolves, Fetches, Anchors" "" "solid" 
        
        backend -> offChainWalletIssuerVerifier "Uses" "" "solid"
        frontend -> backend "Uses" "" "solid"
        user -> frontend "Uses" "HTML" "solid"
        
        offChainWallet -> externalstorage "Uses <optional>" "" "optional" 
        DIDInter1 -> externalstorage "Uses <optional>" "" "optional" 
        VCInter1 -> externalstorage "Uses <optional>" "" "optional"
        
        user -> gui1 "Uses" "" solid
        
        
        #ON CHAIN
        
        user -> onChainWallet "Uses" "" "solid"
        
        dapp -> onChainWallet "Requests" "RPC" "solid"
        cryptoInter2 -> sensitiveMaterial2 "Uses" "" "solid"
        communicationInterface2 -> blockchain "Connects to and sends transactions to" "RPC" "solid"
        dapp -> blockchain "Featches events and data" "RPC" "solid"
        tokenInter -> communicationInterface2 "Uses" "" "solid"
        tokenInter -> cryptoInter2 "Uses" "" "solid"
        web3 -> cryptoInter2 "Uses" "" "solid"
        dapp -> web3 "Requests action" "RPC" "solid"
        web3 -> communicationInterface2 "Uses" "" "solid"
        configInter2 -> cryptoInter2 "Uses" "" "solid"
        configInter2 -> communicationInterface2 "Uses" "" "solid"
        configInter2 -> tokenInter "Uses" "" "solid"
        user -> gui2 "Uses" "" solid
        user -> dapp "Uses" "HTML" "solid"
    }
    
    views {
        
        theme default
        
        
        systemLandscape "SystemLandscape" "From the user perspective" {
            include *
            title "Whole Landscape"
            autoLayout tb 100 100
        }
        
         systemLandscape "SystemLandscape_WalletFocus" "From the user perspective wallet focus" {
            include *
            exclude externalstorage
            title "Landscape Wallet Focus"
            autoLayout tb 180 100
        }
        
        systemContext offChainWallet "offChainWalletSystemContext" {
            include *
            autoLayout tb
        }
        
        systemContext onChainWallet "onChainWalletSystemContext" {
            include *
            autoLayout lr
        }
        
        systemContext issuer_verifier "issuer_verifierSystemContext" {
            include *
            autoLayout
        }
        
        container issuer_verifier "issuer_verifierContainerView" {
            include * 
            autoLayout
        }
        
        
        container offChainWallet "OffChainWalletContainerView" {
            include *
            autoLayout lr 250 50
        }
        container onChainWallet "OnChainWalletContainerView" {
            include *
            autoLayout tb 100 100
        }
        
        container offChainWallet "CustomOffChainWalletContainerView" {
            include * userAuth2 cryptoInter2 sensitiveMaterial2 communicationInterface2 web3 configInter2 gui2 tokenInter dapp user onChainWallet offChainWallet  
            title "Custom Whole"
            autoLayout tb 150 150
        }
        
        
        styles {
        
            element offc {
                background #76b5c5
                color black
                fontSize 30
            }
            
            element onc {
                background #Abc8e3
                color black
                fontSize 30
            }
            
            element storage {
                shape Cylinder
                fontSize 30
            }
            
            element storage_offc {
                shape Cylinder
                background #76b5c5
                color black
                fontSize 30
            }
            
            element storage_onc {
                shape Cylinder
                background #Abc8e3
                color black
                fontSize 30
            }
            
            element storage2 {
                shape Cylinder
                background gray
                fontSize 30
            }
            
            element common {
                background #2481ce
                color white
                fontSize 30
            }
            
            element extra {
                background #eeeee4
                color grey
                fontSize 30
            }
            
            element blockchain {
                shape Pipe
                background gray
                fontSize 30
            }
            
            element dapp {
                shape WebBrowser
                background gray
                fontSize 30
            }
            
            element registry {
                shape Folder
                background gray
                fontSize 30
            }
            
            element issuerverifier {
                shape RoundedBox
                background gray
                fontSize 30
            }
            
            relationship optional {
                
                color grey
                style dashed
                fontSize 30
                
            }
            
            relationship solid {
                
                style solid
                fontSize 30
                
            }
            
        }
    }

}